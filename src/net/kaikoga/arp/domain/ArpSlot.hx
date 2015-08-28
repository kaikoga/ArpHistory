package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpSid;

/**
	Note typed ArpSlot is only typed in API level (enforced in framework logic).
**/
abstract ArpSlot<T:IArpObject>(ArpUntypedSlot) from ArpUntypedSlot to ArpUntypedSlot {

	public function new(value:ArpUntypedSlot) this = value;
	public var arpObject(get, set):T;
	inline public function get_arpObject():T return cast this.arpObject; // FIXME
	inline public function set_arpObject(value:T):T return cast(this.arpObject = cast(value)); // FIXME
}

class ArpUntypedSlot {

	private var domain:ArpDomain;
	private var sid:ArpSid;
	
	private var _arpObject:IArpObject = null;
	public var arpObject(get, set):IArpObject;
	inline public function get_arpObject():IArpObject { return this._arpObject; }
	inline public function set_arpObject(value:IArpObject):IArpObject { return this._arpObject = value; }

	public function new(domain:ArpDomain, sid:ArpSid) {
		this.domain = domain;
		this.sid = sid;
	}

}
