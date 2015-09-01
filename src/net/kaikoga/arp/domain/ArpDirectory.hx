package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.core.ArpDid;

class ArpDirectory {

	public var domain(default, null):ArpDomain;
	private var did:ArpDid;
	private var children:Map<String, ArpDirectory>;
	private var slots:Map<String, ArpUntypedSlot>;
	private var linkDir:ArpDirectory = null;

	public function new(domain:ArpDomain, did:ArpDid) {
		this.domain = domain;
		this.did = did;
		this.children = new Map();
		this.slots = new Map();
	}

	public function getOrCreateSlot(type:ArpType):ArpUntypedSlot {
		if (this.slots.exists(type)) return this.slots.get(type);
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this.domain, this.domain.nextSid());
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

	public function addArpObject(value:IArpObject):Void {
		this.getOrCreateSlot(value.arpType()).value = value;
	}

	public function linkTo(dir:ArpDirectory):Void {
		this.linkDir = dir;
	}
	
	public function child(name:String):ArpDirectory {
		return if (this.linkDir != null) this.linkDir.child(name) else this.trueChild(name);
	}

	public function trueChild(name:String):ArpDirectory {
		if (this.children.exists(name)) return this.children.get(name);
		var child:ArpDirectory = new ArpDirectory(this.domain, this.domain.nextDid());
		this.children.set(name, child);
		return child;
	}

}
