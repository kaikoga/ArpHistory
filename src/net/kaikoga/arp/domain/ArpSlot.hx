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

	public var refCount(get, never):Int;
	inline private function get_refCount():Int return this.refCount;

	inline public function addReference():ArpSlot<T> return this.addReference();
	inline public function delReference():ArpSlot<T> return this.delReference();
	inline public function takeReference(from:ArpSlot<T>):ArpSlot<T> return this.takeReference(from);

	// FIXME make setter friend access
	public var heat(get, set):ArpHeat;
	inline private function get_heat():ArpHeat return this.heat;
	inline private function set_heat(value:ArpHeat):ArpHeat return this.heat = value;

	inline public function toString():String return this.toString();
	inline public function describe():String return this.describe();

	@:noUsing
	public static function of<T:IArpObject>(arpObj:T, domain:ArpDomain):ArpSlot<T> {
		if (arpObj != null) return arpObj.arpSlot();
		return domain.nullSlot;
	}

	@:noUsing
	public static function get<T:IArpObject>(arpObj:T):ArpSlot<T> {
		if (arpObj != null) return arpObj.arpSlot();
		return null;
	}
}

class ArpUntypedSlot {

	private var _domain:ArpDomain = null;
	public var domain(get, set):ArpDomain;
	inline private function get_domain():ArpDomain return this._domain;
	inline private function set_domain(value:ArpDomain):ArpDomain {
		return this._domain = value;
	}

	public var sid(default, null):ArpSid;

	private var _value:IArpObject = null;
	public var value(get, set):IArpObject;
	inline private function get_value():IArpObject return this._value;
	inline private function set_value(value:IArpObject):IArpObject {
		return this._value = value;
	}

	private var _refCount:Int = 0;
	public var refCount(get, never):Int;
	inline private function get_refCount():Int { return this._refCount; }

	inline public function addReference():ArpUntypedSlot { this._refCount++; return this; }
	inline public function delReference():ArpUntypedSlot {
		if (--this._refCount <= 0) {
			if (this._value != null) {
				this._value.arpDispose();
				this._value = null;
			}
		}
		return this;
	}
	inline public function takeReference(from:ArpUntypedSlot):ArpUntypedSlot {
		this.addReference();
		from.delReference();
		return this;
	}

	private var _heat:ArpHeat = ArpHeat.Cold;
	public var heat(get, set):ArpHeat;
	inline private function get_heat():ArpHeat { return this._heat; }
	inline private function set_heat(value:ArpHeat):ArpHeat { return this._heat = value; }

	@:allow(net.kaikoga.arp.domain.ArpDomain)
	private function new(domain:ArpDomain, sid:ArpSid) {
		this.domain = domain;
		this.sid = sid;
	}

	public function toString():String return '<$sid>';
	public function describe():String return '[ArpUntypedSlot <$sid> = $value[$refCount]]';
}
