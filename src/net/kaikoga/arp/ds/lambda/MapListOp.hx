package net.kaikoga.arp.ds.lambda;

class MapListOp {

	public static function copy<K, V>(a:IMapList<K, V>, out:IMapList<K, V>):IMapList<K, V> {
		return out;
	}

	public static function and<K, V>(a:IMapList<K, V>, b:IMapList<K, V>, out:IMapList<K, V>):IMapList<K, V> {
		return out;
	}

	public static function or<K, V>(a:IMapList<K, V>, b:IMapList<K, V>, out:IMapList<K, V>):IMapList<K, V> {
		return out;
	}

	public static function filter<K, V>(source:IMapList<K, V>, func:V->Bool, out:IMapList<K, V>):IMapList<K, V> {
		return out;
	}

	public static function map<K, V, W>(source:IMapList<K, V>, func:V->W, out:IMapList<K, W>):IMapList<K, W> {
		return out;
	}

}
