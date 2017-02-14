package net.kaikoga.arp.seed;

import net.kaikoga.arp.utils.ArpStringUtil;

abstract ArpSeedEnv(ArpSeedEnvNode) {

	inline public static function empty():ArpSeedEnv return new ArpSeedEnv(ArpSeedEnvNode.empty());

	inline private function new(impl:ArpSeedEnvNode) this = impl;

	inline public function get(key:String):String {
		return this.get(key);
	}

	inline public function getDefaultClass(key:String):String {
		return this.get('default.$key');
	}

	inline public function getUnit(unit:String):Float {
		return ArpStringUtil.parseFloatDefault(this.get('unit.$unit'), 1.0);
	}

	inline public function add(key:String, value:String):Void {
		this = new ArpSeedEnvNode(key, value, this);
	}
}

private class ArpSeedEnvNode {

	private var key:String;
	private var value:String;
	private var rest:ArpSeedEnvNode;
	private var map:Map<String, String>;

	inline public static function empty():ArpSeedEnvNode return new ArpSeedEnvNode(null, null, null);

	public function new(key:String, value:String, rest:ArpSeedEnvNode) {
		this.key = key;
		this.value = value;
		this.rest = rest;
	}

	public function get(key:String):String {
		if (this.map == null) {
			this.map = new Map<String, String>();
			var n:ArpSeedEnvNode = this;
			while (n.key != null) {
				this.map.set(n.key, n.value);
				n = n.rest;
			}
		}
		return this.map.get(key);
	}
}
