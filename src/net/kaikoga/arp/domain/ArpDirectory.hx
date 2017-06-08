package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.query.ArpDirectoryQuery;
import net.kaikoga.arp.domain.query.ArpObjectQuery;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.core.ArpDid;

@:access(net.kaikoga.arp.domain.ArpDomain)
class ArpDirectory {

	inline public static var PATH_DELIMITER:String = "/";

	public var domain(default, null):ArpDomain;
	public var did(default, null):ArpDid;
	private var children:Map<String, ArpDirectory>;
	private var slots:Map<String, ArpUntypedSlot>;
	private var linkDir:ArpDirectory = null;

	@:allow(net.kaikoga.arp.domain.ArpDomain)
	private function new(domain:ArpDomain, did:ArpDid) {
		this.domain = domain;
		this.did = did;
		this.children = new Map();
		this.slots = new Map();
	}

	public function getOrCreateSlot(type:ArpType):ArpUntypedSlot {
		if (this.slots.exists(type)) return this.slots.get(type);
		var slot:ArpUntypedSlot = this.domain.allocSlot(ArpSid.build(this.did, type));
		this.slots.set(type, slot);
		return slot;
	}

	public function setSlot(type:ArpType, slot:ArpUntypedSlot):ArpUntypedSlot {
		this.slots.set(type, slot);
		return slot;
	}

	public function getValue(type:ArpType):IArpObject {
		return this.getOrCreateSlot(type).value;
	}

	public function allocObject<T:IArpObject>(klass:Class<T>, args:Array<Dynamic> = null):T {
		if (args == null) args = [];
		return this.addObject(Type.createInstance(klass, args));
	}

	public function addOrphanObject<T:IArpObject>(arpObj:T):T {
		return this.addObject(arpObj);
	}

	private function addObject<T:IArpObject>(arpObj:T):T {
		var slot:ArpSlot<T> = this.getOrCreateSlot(arpObj.arpType);
		slot.value = arpObj;
		arpObj.arpInit(slot);
		return arpObj;
	}

	public function linkTo(dir:ArpDirectory):Void {
		this.linkDir = dir;
	}

	public function child(name:String):ArpDirectory {
		return if (this.linkDir != null) this.linkDir.child(name) else this.trueChild(name);
	}

	public function trueChild(name:String):ArpDirectory {
		if (this.children.exists(name)) return this.children.get(name);
		var child:ArpDirectory = this.domain.allocDir(ArpDid.build(this.did, name));
		this.children.set(name, child);
		return child;
	}

	inline public function dir(path:String = null):ArpDirectory {
		return new ArpDirectoryQuery(this, path).directory();
	}

	inline public function query<T:IArpObject>(path:String = null, type:ArpType = null):ArpObjectQuery<T> {
		return new ArpObjectQuery(this, path, type);
	}
}
