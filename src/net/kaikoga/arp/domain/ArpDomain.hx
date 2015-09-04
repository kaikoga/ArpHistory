package net.kaikoga.arp.domain;

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
		this.root = this.allocDir("");
		this.slots = new Map();
		this.nullSlot = this.allocSlot("");
		this.reg = new ArpGeneratorRegistry();
	}

	private function allocSlot(name:String = null):ArpUntypedSlot {
		if (name == null) name = '@s${Std.string(_sid++)}';
		var sid:ArpSid = new ArpSid(name);
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this, sid);
		this.slots.set(cast sid, slot);
		return slot;
	}

	private function allocDir(name:String = null):ArpDirectory {
		if (name == null) name = '@${Std.string(_did++)}';
		var did:ArpDid = new ArpDid(name);
		return new ArpDirectory(this, did);
	}

	private function slot<T:IArpObject>(sid:ArpSid):ArpSlot<T> {
		return this.slots.get(cast sid);
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

	public function loadSeed<T:IArpObject>(seed:ArpSeed, path:ArpDirectory = null, lexicalType:ArpType = null):ArpSlot<T> {
		if (path == null) path = this.root;
		var type:ArpType = (lexicalType != null) ? lexicalType : cast seed.typeName();
		var slot:ArpSlot<T>;
		if (seed.ref() != null) {
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

	public function flush():Void {
		throw "ArpDomain.flush()";
	}

	public function gc():Void {
		throw "ArpDomain.gc()";
	}
}
