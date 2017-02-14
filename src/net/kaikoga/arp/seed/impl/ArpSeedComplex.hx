package net.kaikoga.arp.seed.impl;

import net.kaikoga.arp.seed.ArpSeedValueKind;

class ArpSeedComplex extends ArpSeed {

	private var children:Array<ArpSeed>;

	private function new(typeName:String, className:String, name:String, heat:String, key:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName, className, name, heat, key, env);
		this.children = children;
	}

	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.None;
	override private function get_value():String return null;
	override private function get_isSimple():Bool return false;

	override public function iterator():Iterator<ArpSeed> return this.children.iterator();
}
