package net.kaikoga.arp.ds.lambda;

class OmapOp {

	public static function copy<K, V>(a:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		return out;
	}

	public static function and<K, V>(a:IOmap<K, V>, b:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		return out;
	}

	public static function or<K, V>(a:IOmap<K, V>, b:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		return out;
	}

	public static function filter<K, V>(source:IOmap<K, V>, func:V->Bool, out:IOmap<K, V>):IOmap<K, V> {
		return out;
	}

	public static function map<K, V, W>(source:IOmap<K, V>, func:V->W, out:IOmap<K, W>):IOmap<K, W> {
		return out;
	}

	public static function bulkAddPair<K, V>(target:IOmap<K, V>, source:IOmap<K, V>):IOmap<K, V> {
		for (k in source.keys()) target.addPair(k, source.get(k));
		return target;
	}

	public static function bulkAddPairAnon<V>(target:IOmap<String, V>, source:Dynamic):IOmap<String, V> {
		for (k in Reflect.fields(source)) target.addPair(k, Reflect.field(source, k));
		return target;
	}

	public static function toKeyArray<K, V>(source:IOmap<K, V>):Array<K> {
		return [for (k in source.keys()) k];
	}

	public static function toArray<K, V>(source:IOmap<K, V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon<V>(source:IOmap<String, V>):Dynamic {
		var anon:Dynamic = {};
		for (k in source.keys()) Reflect.setField(anon, k, source.get(k));
		return anon;
	}
}
