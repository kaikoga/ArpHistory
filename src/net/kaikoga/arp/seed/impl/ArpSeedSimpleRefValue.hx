package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedKind;

class ArpSeedSimpleRefValue extends ArpSeed {

	private function new(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, children:Array<ArpSeed>) {
		super(typeName, className, name, heat, key, value, env, children);
	}

	override private function get_kind():ArpSeedKind return ArpSeedKind.SimpleRefValue;
	override private function get_ref():String return this.value;
	override private function get_isSimple():Bool return true;

	override public function iterator():Iterator<ArpSeed> {
		if (this.value == null) return ArpSeed.emptyChildren.iterator();
		return [ArpSeed.simpleValue("value", "$$", this.value, this.env)].iterator();
	}
}
