package arp.seed.impl;

import arp.seed.ArpSeedValueKind;

class ArpComplexSeed extends ArpSeed {

	private var _key:String;
	private var _env:ArpSeedEnv;

	public function new(typeName:String, className:String, name:String, key:String, heat:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName, new ArpSeedElement(className, name, heat, children));
		this._key = key;
		this._env = env;
	}

	override private function get_key():String return this._key;
	override private function get_value():String return this.element.value;
	override private function get_env():ArpSeedEnv return this._env;
	override private function get_valueKind():ArpSeedValueKind return if (this.element.isSimple) ArpSeedValueKind.Literal else ArpSeedValueKind.None;
	override private function get_isSimple():Bool return this.element.isSimple;

	override public function iterator():Iterator<ArpSeed> return this.element.iterator();
}
