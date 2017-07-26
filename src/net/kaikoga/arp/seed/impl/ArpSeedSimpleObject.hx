package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedValueKind;

class ArpSeedSimpleObject extends ArpSeed {

	private var rawValue:ArpSeedRawValue;

	public function new(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv) {
		super(typeName, className, name, heat);
		this.rawValue = new ArpSeedRawValue(key, value, env);
	}

	override private function get_key():String return this.rawValue._key;
	override private function get_value():String return this.rawValue._value;
	override private function get_env():ArpSeedEnv return this.rawValue._env;
	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.Literal;
	override private function get_isSimple():Bool return true;

	override public function iterator():Iterator<ArpSeed> return this.rawValue.iterator();
}