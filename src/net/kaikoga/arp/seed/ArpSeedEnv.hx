package net.kaikoga.arp.seed;

import net.kaikoga.arp.structs.ArpStructsUtil;
import net.kaikoga.arp.ds.lambda.MapOp;
import net.kaikoga.arp.ds.impl.StdMap;

abstract ArpSeedEnv(StdMap<String, String>) {

	inline public static function empty():ArpSeedEnv return new ArpSeedEnv(new StdMap());

	inline public function new(map:StdMap<String, String>) this = map;

	inline public function get(key:String):String {
		return this.get(key);
	}

	inline public function getUnit(unit:String):Float {
		return ArpStructsUtil.parseFloatDefault(this.get(unit), 1.0);
	}

	inline public function add(key:String, value:String):Void {
		this = MapOp.copy(this, new StdMap<String, String>());
		this.set(key, value);
	}
}
