package net.kaikoga.arp.domain;

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

	public var root(default, null):ArpDirectory;
	private var slots:Map<String, ArpUntypedSlot>;
	public var nullSlot(default, null):ArpUntypedSlot;

	private var reg:ArpGeneratorRegistry;

	private var _sid:Int = 0;
	private var _did:Int = 0;

	public function new() {
		this.root = this.allocDir(new ArpDid(""));
		this.slots = new Map();
		this.nullSlot = this.allocSlot(new ArpSid(""));
		this.reg = new ArpGeneratorRegistry();
	}

	private function allocSlot(sid:ArpSid = null):ArpUntypedSlot {
		if (sid == null) sid = new ArpSid('@s${Std.string(_sid++)}');
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this, sid);
		this.slots.set(sid.toString(), slot);
		return slot;
	}

	private function allocDir(did:ArpDid = null):ArpDirectory {
		if (did == null) did = new ArpDid('@${Std.string(_did++)}');
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

	public function addGenerator<T:IArpObject>(gen:IArpGenerator<T>) {
		this.reg.addGenerator(gen);
	}

	public function loadSeed<T:IArpObject>(seed:ArpSeed, path:ArpDirectory = null, lexicalType:ArpType = null):Null<ArpSlot<T>> {
		if (path == null) path = this.root;
		var type:ArpType = (lexicalType != null) ? lexicalType : new ArpType(seed.typeName());
		var slot:ArpSlot<T>;
		if (seed.typeName() == "data") {
			for (child in seed) loadSeed(child, path, null);
			slot = null;
		} else if (seed.ref() != null) {
			slot = path.query(seed.ref(), type).slot();
			if (seed.name() != null) {
				path.query(seed.name(), type).setSlot(slot);
			}
		} else {
			slot = path.query(seed.name(), type).slot();
			var gen:IArpGenerator<T> = this.reg.resolve(seed, type);
			var arpObj:T = gen.alloc(seed);
			slot.value = arpObj;
			arpObj.init(slot, seed);
		}
		return slot;
	}

	public function allocObject<T:IArpObject>(klass:Class<T>, args:Array<Dynamic> = null, sid:ArpSid = null):T {
		if (args == null) args = [];
		return this.addObject(Type.createInstance(klass, args), sid);
	}

	public function addObject<T:IArpObject>(object:T, sid:ArpSid = null):T {
		var slot:ArpSlot<T> = (sid != null) ? this.getOrCreateSlot(sid) : this.allocSlot(sid);
		object.init(slot);
		return object;
	}

	public function flush():Void {
		throw "ArpDomain.flush()";
	}

	public function gc():Void {
		throw "ArpDomain.gc()";
	}

	public function dumpEntries(typeFilter:ArpType->Bool = null):String {
		return ArpDomainDump.printer.format(new ArpDomainDump(this, typeFilter).dumpSlotStatus());
	}

	public function dumpEntriesByName(typeFilter:ArpType->Bool = null):String {
		return ArpDomainDump.printer.format(new ArpDomainDump(this, typeFilter).dumpSlotStatusByName());
	}
}
