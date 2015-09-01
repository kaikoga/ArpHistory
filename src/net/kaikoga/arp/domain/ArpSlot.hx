package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpSid;

/**
	Note typed ArpSlot is only typed in API level (enforced in framework logic).
**/
abstract ArpSlot<T:IArpObject>(ArpUntypedSlot) from ArpUntypedSlot to ArpUntypedSlot {

	public function new(value:ArpUntypedSlot) this = value;

	public var domain(get, never):ArpDomain;
	inline public function get_domain():ArpDomain return this.domain;

	public var value(get, set):T;
	inline public function get_value():T return cast this.value; // FIXME
	inline public function set_value(value:T):T return cast(this.value = cast(value)); // FIXME
}

class ArpUntypedSlot {

	public var domain(default, null):ArpDomain;
	private var sid:ArpSid;
	
	private var _value:IArpObject = null;
	public var value(get, set):IArpObject;
	inline public function get_value():IArpObject { return this._value; }
	inline public function set_value(value:IArpObject):IArpObject { return this._value = value; }

	public function new(domain:ArpDomain, sid:ArpSid) {
		this.domain = domain;
		this.sid = sid;
	}

}
