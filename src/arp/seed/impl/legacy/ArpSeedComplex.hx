package arp.seed.impl.legacy;

import arp.seed.ArpSeedValueKind;

class ArpSeedComplex extends ArpSeed {

	private var _key:String;
	private var _env:ArpSeedEnv;

	public function new(typeName:String, className:String, name:String, heat:String, key:String, children:Array<ArpSeed>, env:ArpSeedEnv) {
		super(typeName, new ArpSeedElement(className, name, heat, children));
		this._key = key;
		this._env = env;
	}

	override private function get_key():String return this._key;
	override private function get_value():String return null;
	override private function get_env():ArpSeedEnv return this._env;
	override private function get_valueKind():ArpSeedValueKind return ArpSeedValueKind.None;
	override private function get_isSimple():Bool return false;

	override public function iterator():Iterator<ArpSeed> return this.element.iterator();
}
