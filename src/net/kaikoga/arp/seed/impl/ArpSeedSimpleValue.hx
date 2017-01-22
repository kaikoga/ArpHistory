package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedKind;

class ArpSeedSimpleValue extends ArpSeed {

	private static var emptyChildren:Array<ArpSeed> = [];

	private var _value:String;

	private function new(typeName:String, key:String, value:String, env:ArpSeedEnv) {
		super(typeName, null, null, null, key, env);
		this._value = value;
	}

	override private function get_kind():ArpSeedKind return ArpSeedKind.SimpleValue;
	override private function get_ref():String return null;
	override private function get_value():String return this._value;
	override private function get_isSimple():Bool return true;

	override public function iterator():Iterator<ArpSeed> {
		if (this.value == null) return emptyChildren.iterator();
		return [ArpSeed.simpleValue("value", "$$", this.value, this.env)].iterator();
	}
}
