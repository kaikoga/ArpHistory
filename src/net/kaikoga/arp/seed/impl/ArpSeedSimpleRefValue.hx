package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedValueKind;

class ArpSeedSimpleRefValue extends ArpSeed {

	private static var emptyChildren:Array<ArpSeed> = [];

	private var _value:String;

	public function new(typeName:String, key:String, value:String, env:ArpSeedEnv) {
		super(typeName, null, null, null, key, env);
		this._value = value;
	}

	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.Ambigious;
	override private function get_value():String return this._value;
	override private function get_isSimple():Bool return true;

	override public function iterator():Iterator<ArpSeed> {
		if (this.value == null) return emptyChildren.iterator();
		return [new ArpSeedSimpleValue("value", "$$", this.value, this.env)].iterator();
	}
}
