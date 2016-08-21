package net.kaikoga.arp.domain.gen;

import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

class ArpDynamicGenerator<T:IArpObject> implements IArpGenerator<T> {

	private var _arpType:ArpType;
	private var dest:Class<T>;
	private var _template:String;
	private var _isDefault:Bool;

	public var arpType(get, never):ArpType;
	private function get_arpType():ArpType return this._arpType;
	public var template(get, never):String;
	private function get_template():String return this._template;
	public var isDefault(get, never):Bool;
	private function get_isDefault():Bool return this._isDefault;

	public function new(source:ArpType, dest:Class<T>, template:String, isDefault:Bool) {
		this._arpType = source;
		this.dest = dest;
		this._template = template;
		this._isDefault = isDefault;
	}

	public function matchSeed(seed:ArpSeed, type:ArpType, template:String):Bool {
		return type == this._arpType && template == this._template;
	}

	public function alloc(seed:ArpSeed):T {
		return Type.createInstance(dest, []);
	}
}
