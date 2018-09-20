package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	private var element:ArpSeedElement;

	public function new(typeName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName);
		this.key = key;
		this.env = env;
		this.element = new ArpSeedElement(className, name, heat, children);
	}

	override private function get_isSimple():Bool return this.element.isSimple;
	override private function get_value():String return this.element.value;
	override private function get_valueKind():ArpSeedValueKind return this.element.valueKind;

	override private function get_className():String return element.className;
	override private function get_name():String return element.name;
	override private function get_heat():String return element.heat;

	override public function iterator():Iterator<ArpSeed> return this.element.iterator();
}
