package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedKind;

class ArpSeedComplex extends ArpSeed {

	private function new(typeName:String, className:String, name:String, heat:String, key:String, value:String, env:ArpSeedEnv, children:Array<ArpSeed>) {
		super(typeName, className, name, heat, key, value, env, children);
	}

	override private function get_kind():ArpSeedKind return ArpSeedKind.Complex;
	override private function get_ref():String return null;
	override private function get_isSimple():Bool return false;

	override public function iterator():Iterator<ArpSeed> return this.children.iterator();
}
