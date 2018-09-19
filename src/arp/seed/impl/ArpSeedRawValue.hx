package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpSeedRawValue extends ArpSeed {

	private static var emptyChildren:Array<ArpSeed> = [];

	@:allow(arp.seed.ArpSeed)
	private var _key:String;
	@:allow(arp.seed.ArpSeed)
	private var _value:String;
	@:allow(arp.seed.ArpSeed)
	private var _env:ArpSeedEnv;

	public function new(key:String, value:String, env:ArpSeedEnv) {
		super("value", null);
		this._key = key;
		this._value = value;
		this._env = env;
	}

	override private function get_key():String return this._key;
	override private function get_value():String return this._value;
	override private function get_env():ArpSeedEnv return this._env;
	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.Literal;
	override private function get_isSimple():Bool return true;

	override inline public function iterator():Iterator<ArpSeed> {
		return (this._value == null ? emptyChildren : [(this:ArpSeed)]).iterator();
	}
}
