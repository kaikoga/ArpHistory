package net.kaikoga.arp.ds.lambda;

class MapOp {

	public static function copy<K, V>(a:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		return out;
	}

	public static function and<K, V>(a:IMap<K, V>, b:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		return out;
	}

	public static function or<K, V>(a:IMap<K, V>, b:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		return out;
	}

	public static function filter<K, V>(source:IMap<K, V>, func:V->Bool, out:IMap<K, V>):IMap<K, V> {
		return out;
	}

	public static function map<K, V, W>(source:IMap<K, V>, func:V->W, out:IMap<K, W>):IMap<K, W> {
		return out;
	}

}
