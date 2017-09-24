package net.kaikoga.arp.domain;

import net.kaikoga.arp.data.DataGroup;
import net.kaikoga.arp.domain.ArpSlot;
import net.kaikoga.arp.domain.core.ArpDid;
import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.dump.ArpDomainDump;
import net.kaikoga.arp.domain.events.ArpLogEvent;
import net.kaikoga.arp.domain.gen.ArpGeneratorRegistry;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.domain.gen.IArpGenerator;
import net.kaikoga.arp.domain.prepare.IPrepareStatus;
import net.kaikoga.arp.domain.prepare.PrepareQueue;
import net.kaikoga.arp.domain.query.ArpObjectQuery;
import net.kaikoga.arp.events.ArpSignal;
import net.kaikoga.arp.events.IArpSignalIn;
import net.kaikoga.arp.events.IArpSignalOut;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.seed.ArpSeedValueKind;
import net.kaikoga.arp.seed.SeedObject;
import net.kaikoga.arp.utils.ArpIdGenerator;

@:allow(net.kaikoga.arp.domain.ArpDirectory)
@:allow(net.kaikoga.arp.domain.ArpUntypedSlot)
class ArpDomain {

	public var root(default, null):ArpDirectory;
	private var currentDir:ArpDirectory;

	private var slots:Map<String, ArpUntypedSlot>;
	public var nullSlot(default, null):ArpUntypedSlot;

	private var prepareQueue:PrepareQueue;

	private var reg:ArpGeneratorRegistry;

	private var _sid:ArpIdGenerator = new ArpIdGenerator();
	private var _did:ArpIdGenerator = new ArpIdGenerator();

	private var _rawTick:ArpSignal<Float>;
	public var rawTick(get, never):IArpSignalIn<Float>;
	inline private function get_rawTick():IArpSignalIn<Float> return this._rawTick;

	private var _prepareTick:ArpSignal<Float>;

	private var _tick:ArpSignal<Float>;
	public var tick(get, never):IArpSignalOut<Float>;
	inline private function get_tick():IArpSignalOut<Float> return this._tick;

	private var _onLog:ArpSignal<ArpLogEvent>;
	public var onLog(get, never):IArpSignalOut<ArpLogEvent>;
	inline private function get_onLog():IArpSignalOut<ArpLogEvent> return this._onLog;

	public var prepareStatus(get, never):IPrepareStatus;
	inline private function get_prepareStatus():IPrepareStatus return this.prepareQueue;

	public function new() {
		this._rawTick = new ArpSignal<Float>();
		this._prepareTick = new ArpSignal<Float>();
		this._tick = new ArpSignal<Float>();
		this._onLog = new ArpSignal<ArpLogEvent>();

		this.root = this.allocDir(new ArpDid(""));
		this.currentDir = this.root;
		this.slots = new Map();
		this.nullSlot = this.allocSlot(new ArpSid(ArpIdGenerator.AUTO_HEADER + "null"));
		this.reg = new ArpGeneratorRegistry();
		this.prepareQueue = new PrepareQueue(this, this._rawTick);

		this._rawTick.push(this.onRawTick);

		this.addGenerator(new ArpObjectGenerator(DataGroup));
		this.addGenerator(new ArpObjectGenerator(SeedObject));
	}

	private function onRawTick(v:Float):Void {
		if (this.prepareQueue.isPending) {
			this._prepareTick.dispatch(v);
		} else {
			this._tick.dispatch(v);
		}
	}

	private function allocSlot(sid:ArpSid = null, type:String = null):ArpUntypedSlot {
		if (sid == null) sid = new ArpSid(_sid.next());
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this, sid);
		this.slots.set(sid.toString(), slot);
		return slot;
	}

	private function freeSlot(slot:ArpUntypedSlot):Void {
		this.slots.remove(slot.sid.toString());
	}

	private function allocDir(did:ArpDid = null):ArpDirectory {
		if (did == null) did = new ArpDid(_did.next());
		return new ArpDirectory(this, did);
	}

	public function getSlot<T:IArpObject>(sid:ArpSid):ArpSlot<T> {
		return this.slots.get(sid.toString());
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

	public function loadSeed<T:IArpObject>(seed:ArpSeed, lexicalType:ArpType = null):Null<ArpSlot<T>> {
		var type:ArpType = (lexicalType != null) ? lexicalType : new ArpType(seed.typeName);
		var slot:ArpSlot<T>;
		var name:String;
		switch (seed.valueKind) {
			case ArpSeedValueKind.Reference, ArpSeedValueKind.Ambigious if (seed.value != null):
				slot = this.root.query(seed.value, type).slot();
				name = seed.name;
				if (name != null) {
					this.root.query(name, type).setSlot(slot);
				}
			case _:
				name = seed.name;
				var oldDir:ArpDirectory = this.currentDir;
				if (name == null) {
					slot = allocSlot(new ArpSid('${_sid.next()}:${type}')); // FIXME
				} else {
					var dir:ArpDirectory = this.currentDir.dir(name);
					slot = dir.getOrCreateSlot(type);
					this.currentDir = dir;
				}
				var gen:IArpGenerator<T> = this.reg.resolve(seed, type);
				if (gen == null) throw 'generator not found for <$type>: class=${seed.className}';
				var arpObj:T = gen.alloc(seed);
				var init = arpObj.arpInit(slot, seed);
				this.currentDir = oldDir;
				if (init != null) {
					slot.value = arpObj;
					switch (ArpHeat.fromName(seed.heat)) {
						case ArpHeat.Cold:
						case ArpHeat.Warming, ArpHeat.Warm: this.heatLater(slot);
					}
				}
		}
		return slot;
	}

	public function allocObject<T:IArpObject>(klass:Class<T>, args:Array<Dynamic> = null, sid:ArpSid = null):T {
		if (args == null) args = [];
		return this.addObject(Type.createInstance(klass, args), sid);
	}

	public function addOrphanObject<T:IArpObject>(arpObj:T):T {
		return this.addObject(arpObj);
	}

	private function addObject<T:IArpObject>(arpObj:T, sid:ArpSid = null):T {
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

	public function heatLater(slot:ArpUntypedSlot, required:Bool = false):Void {
		this.prepareQueue.prepareLater(slot, required);
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

	public function waitFor(obj:IArpObject):Void this.prepareQueue.waitBySlot(obj.arpSlot);

	public function notifyFor(obj:IArpObject):Void this.prepareQueue.notifyBySlot(obj.arpSlot);
}
