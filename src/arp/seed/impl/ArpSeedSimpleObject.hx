package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpSeedSimpleObject extends ArpSeed {

	private var rawValue:ArpSeedRawValue;

	public function new(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv) {
		rawValue = new ArpSeedRawValue(key, value, env);
		super(typeName, new ArpSeedElement(className, name, heat, if (value != null) [rawValue] else []));
	}

	override private function get_key():String return this.rawValue._key;
	override private function get_value():String return this.rawValue._value;
	override private function get_env():ArpSeedEnv return this.rawValue._env;
	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.Literal;
	override private function get_isSimple():Bool return true;

	override public function iterator():Iterator<ArpSeed> return this.element.iterator();
}
