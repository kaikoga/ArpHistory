package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.core.ArpDid;

class ArpDirectory {

	private var domain:ArpDomain;
	private var did:ArpDid;
	private var children:Map<String, ArpDirectory>;
	private var slots:Map<String, ArpUntypedSlot>;

	public function new(domain:ArpDomain, did:ArpDid) {
		this.domain = domain;
		this.did = did;
		this.children = new Map();
		this.slots = new Map();
	}

	public function getOrCreateSlot(arpType:ArpType):ArpUntypedSlot {
		if (this.slots.exists(arpType)) return this.slots.get(arpType);
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this.domain, this.domain.nextSid());
		this.slots.set(arpType, slot);
		return slot;
	}

	public function setSlot(arpType:ArpType, slot:ArpUntypedSlot):ArpUntypedSlot {
		this.slots.set(arpType, slot);
		return slot;
	}

	public function getArpObject(arpType:ArpType):IArpObject {
		return this.getOrCreateSlot(arpType).arpObject;
	}

	public function addArpObject(arpObject:IArpObject):Void {
		this.getOrCreateSlot(arpObject.arpType()).arpObject = arpObject;
	}

	public function getOrCreateChild(name:String):ArpDirectory {
		if (this.children.exists(name)) return this.children.get(name);
		var child:ArpDirectory = new ArpDirectory(this.domain, this.domain.nextDid());
		this.children.set(name, child);
		return child;
	}

	public function setChild(name:String, child:ArpDirectory):ArpDirectory {
		this.children.set(name, child);
		return child;
	}
}
