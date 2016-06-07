package net.kaikoga.arp.domain;

import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.IArpSignalOut;
import net.kaikoga.arp.domain.events.ArpLogEvent;
import net.kaikoga.arp.events.ArpSignal;
import net.kaikoga.arp.domain.prepare.PrepareQueue;
import net.kaikoga.arp.domain.dump.ArpDomainDump;
import net.kaikoga.arp.domain.gen.ArpGeneratorRegistry;
import net.kaikoga.arp.domain.gen.IArpGenerator;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.query.ArpObjectQuery;
import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.core.ArpDid;

class ArpDomain {

	inline private static var AUTO_HEADER:String = "$";

	public var root(default, null):ArpDirectory;
	private var slots:Map<String, ArpUntypedSlot>;
	public var nullSlot(default, null):ArpUntypedSlot;

	private var prepareQueue:PrepareQueue;

	private var reg:ArpGeneratorRegistry;

	private var _sid:Int = 0;
	private var _did:Int = 0;

	private var _rawTick:ArpSignal<Float>;
	public var rawTick(get, never):IArpSignalIn<Float>;
	inline private function get_rawTick():IArpSignalIn<Float> return this._rawTick;

	private var _tick:ArpSignal<Float>;
	public var tick(get, never):IArpSignalOut<Float>;
	inline private function get_tick():IArpSignalOut<Float> return this._tick;

	private var _onLog:ArpSignal<ArpLogEvent>;
	public var onLog(get, never):IArpSignalOut<ArpLogEvent>;
	inline private function get_onLog():IArpSignalOut<ArpLogEvent> return this._onLog;

	public function new() {
		this._rawTick = new ArpSignal<Float>();
		this._tick = new ArpSignal<Float>();
		this._onLog = new ArpSignal<ArpLogEvent>();

		this.root = this.allocDir(new ArpDid(""));
		this.slots = new Map();
		this.nullSlot = this.allocSlot(new ArpSid(""));
		this.reg = new ArpGeneratorRegistry();
		this.prepareQueue = new PrepareQueue(this, this._rawTick);

		// TODO deal with pending
		this._rawTick.push(function(v) this._tick.dispatch(v));
	}

	private function allocSlot(sid:ArpSid = null):ArpUntypedSlot {
		if (sid == null) sid = new ArpSid('$AUTO_HEADER${Std.string(_sid++)}');
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this, sid);
		this.slots.set(sid.toString(), slot);
		return slot;
	}

	private function allocDir(did:ArpDid = null):ArpDirectory {
		if (did == null) did = new ArpDid('$AUTO_HEADER${Std.string(_did++)}');
		return new ArpDirectory(this, did);
	}

	public function getOrCreateSlot<T:IArpObject>(sid:ArpSid):ArpSlot<T> {
		var slot:ArpSlot<T> = this.slots.get(sid.toString());
		if (slot != null) return slot;
		return allocSlot(sid);
	}

	inline public function dir(path:String = null):ArpDirectory {
		return this.root.dir(path);
	}

	inline public function query<T:IArpObject>(path:String = null, type:ArpType = null):ArpObjectQuery<T> {
		return this.root.query(path, type);
	}

	public var allArpTypes(get, never):Array<ArpType>;
	public function get_allArpTypes():Array<ArpType> return this.reg.allArpTypes();

	public function addGenerator<T:IArpObject>(gen:IArpGenerator<T>) {
		this.reg.addGenerator(gen);
	}

	public function loadSeed<T:IArpObject>(seed:ArpSeed, path:ArpDirectory = null, lexicalType:ArpType = null):Null<ArpSlot<T>> {
		if (path == null) path = this.root;
		var type:ArpType = (lexicalType != null) ? lexicalType : new ArpType(seed.typeName());
		var slot:ArpSlot<T>;
		var name:String;
		if (seed.typeName() == "data") {
			// NOTE seed iterates through value, which we must ignore for data groups
			for (child in seed) if (child.typeName() != "value") loadSeed(child, path, null);
			slot = null;
		} else if (seed.ref() != null) {
			slot = path.query(seed.ref(), type).slot();
			name = seed.name();
			if (name != null) path.query(name, type).setSlot(slot);
		} else {
			name = seed.name();
			slot = if (name == null) allocSlot() else path.query(name, type).slot();
			slot.addReference();
			var gen:IArpGenerator<T> = this.reg.resolve(seed, type);
			if (gen == null) throw 'generator not found for <$type>: template=${seed.template()}';
			var arpObj:T = gen.alloc(seed);
			slot.value = arpObj;
			arpObj.arpInit(slot, seed);
			switch (seed.heat()) {
				case ArpHeat.Cold:
				case ArpHeat.Warming, ArpHeat.Warm: this.heatLater(slot);
			}
		}
		return slot;
	}

	public function allocObject<T:IArpObject>(klass:Class<T>, args:Array<Dynamic> = null, sid:ArpSid = null):T {
		if (args == null) args = [];
		return this.addObject(Type.createInstance(klass, args), sid);
	}

	public function addObject<T:IArpObject>(arpObj:T, sid:ArpSid = null):T {
		var slot:ArpSlot<T> = (sid != null) ? this.getOrCreateSlot(sid) : this.allocSlot(sid);
		slot.value = arpObj;
		arpObj.arpInit(slot);
		return arpObj;
	}

	public function flush():Void {
		throw "ArpDomain.flush()";
	}

	public function gc():Void {
		throw "ArpDomain.gc()";
	}

	public function log(category:String, message:String):Void {
		this._onLog.dispatch(new ArpLogEvent(category, message));
	}

	public function heatLater(slot:ArpUntypedSlot):Void {
		this.prepareQueue.prepareLater(slot);
	}

	public function heatDown(slot:ArpUntypedSlot):Void {
		slot.value.arpHeatDown();
		slot.heat = ArpHeat.Cold;
	}

	public var isPending(get, never):Bool;
	inline public function get_isPending():Bool return this.prepareQueue.isPending;

	public var tasksProcessed(get, never):Int;
	inline private function get_tasksProcessed():Int return this.prepareQueue.tasksProcessed;

	public var tasksTotal(get, never):Int;
	inline private function get_tasksTotal():Int return this.prepareQueue.tasksTotal;

	public var tasksWaiting(get, never):Int;
	inline private function get_tasksWaiting():Int return this.prepareQueue.tasksWaiting;

	public function dumpEntries(typeFilter:ArpType->Bool = null):String {
		return ArpDomainDump.printer.format(new ArpDomainDump(this, typeFilter).dumpSlotStatus());
	}

	public function dumpEntriesByName(typeFilter:ArpType->Bool = null):String {
		return ArpDomainDump.printer.format(new ArpDomainDump(this, typeFilter).dumpSlotStatusByName());
	}

	public function waitFor(obj:IArpObject):Void this.prepareQueue.waitBySlot(obj.arpSlot());

	public function notifyFor(obj:IArpObject):Void this.prepareQueue.notifyBySlot(obj.arpSlot());
}
