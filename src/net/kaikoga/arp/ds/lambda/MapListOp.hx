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

	public static function bulkAddPair<K, V>(target:IMapList<K, V>, source:IMapList<K, V>):IMapList<K, V> {
		for (k in source.keys()) target.addPair(k, source.get(k));
		return target;
	}

	public static function bulkAddPairAnon<V>(target:IMapList<String, V>, source:Dynamic):IMapList<String, V> {
		for (k in Reflect.fields(source)) target.addPair(k, Reflect.field(source, k));
		return target;
	}

	public static function toKeyArray<K, V>(source:IMapList<K, V>):Array<K> {
		return [for (k in source.keys()) k];
	}

	public static function toArray<K, V>(source:IMapList<K, V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon<V>(source:IMapList<String, V>):Dynamic {
		var anon:Dynamic = {};
		for (k in source.keys()) Reflect.setField(anon, k, source.get(k));
		return anon;
	}
}
