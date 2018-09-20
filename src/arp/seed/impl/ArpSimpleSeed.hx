package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpSimpleSeed extends ArpSeed {

	private static var emptyChildren:Array<ArpSeed> = [];

	private var _key:String;
	private var _env:ArpSeedEnv;
	private var _value:String;
	private var _valueKind:ArpSeedValueKind;

	public function new(typeName:String, key:String, value:String, env:ArpSeedEnv, valueKind:ArpSeedValueKind) {
		super(typeName, null);
		this._key = key;
		this._env = env;
		this._value = value;
		this._valueKind = valueKind;
	}

	override private function get_key():String return this._key;
	override private function get_env():ArpSeedEnv return this._env;
	override private function get_value():String return this._value;
	override private function get_valueKind():ArpSeedValueKind return this._valueKind;
	override private function get_isSimple():Bool return true;

	override inline public function iterator():Iterator<ArpSeed> {
		return (this._value == null ? emptyChildren : [(this:ArpSeed)]).iterator();
	}
}
