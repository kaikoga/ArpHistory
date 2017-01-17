package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpDynamicGenerator<T:IArpObject> implements IArpGenerator<T> {

	private var _arpType:ArpType;
	private var dest:Class<T>;
	private var _className:String;
	private var _isDefault:Bool;

	public var arpType(get, never):ArpType;
	private function get_arpType():ArpType return this._arpType;
	public var className(get, never):String;
	private function get_className():String return this._className;
	public var isDefault(get, never):Bool;
	private function get_isDefault():Bool return this._isDefault;

	public function new(source:ArpType, dest:Class<T>, className:String, isDefault:Bool) {
		this._arpType = source;
		this.dest = dest;
		this._className= className;
		this._isDefault = isDefault;
	}

	public function matchSeed(seed:ArpSeed, type:ArpType, className:String):Bool {
		return type == this._arpType && className == this._className;
	}

	public function alloc(seed:ArpSeed):T {
		return Type.createInstance(dest, []);
	}
}
