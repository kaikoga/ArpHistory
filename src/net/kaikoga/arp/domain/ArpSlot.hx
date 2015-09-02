package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpSid;

/**
	Note typed ArpSlot is only typed in API level (enforced in framework logic).
**/
abstract ArpSlot<T:IArpObject>(ArpUntypedSlot) from ArpUntypedSlot to ArpUntypedSlot {

	private function new(value:ArpUntypedSlot) this = value;

	public var domain(get, never):ArpDomain;
	inline private function get_domain():ArpDomain return this.domain;

	public var sid(get, never):ArpSid;
	inline private function get_sid():ArpSid return this.sid;

	public var value(get, set):T;
	inline private function get_value():T return cast this.value; // FIXME
	inline private function set_value(value:T):T return cast(this.value = cast(value)); // FIXME
}

class ArpUntypedSlot {

	public var domain(default, null):ArpDomain;
	public var sid(default, null):ArpSid;
	
	private var _value:IArpObject = null;
	public var value(get, set):IArpObject;
	inline private function get_value():IArpObject { return this._value; }
	inline private function set_value(value:IArpObject):IArpObject { return this._value = value; }

	@:allow(net.kaikoga.arp.domain.ArpDomain)
	private function new(domain:ArpDomain, sid:ArpSid) {
		this.domain = domain;
		this.sid = sid;
	}

}
