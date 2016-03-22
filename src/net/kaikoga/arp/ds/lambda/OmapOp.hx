package net.kaikoga.arp.ds.lambda;

class OmapOp {

	public static function copy<K, V>(source:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		for (k in source.keys()) out.addPair(k, source.get(k));
		return out;
	}

	public static function and<K, V>(a:IOmap<K, V>, b:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		for (k in a.keys()) if (b.hasKey(k)) out.addPair(k, a.get(k));
		return out;
	}

	public static function or<K, V>(a:IOmap<K, V>, b:IOmap<K, V>, out:IOmap<K, V>):IOmap<K, V> {
		for (k in a.keys()) out.addPair(k, a.get(k));
		for (k in b.keys()) if (!a.hasKey(k)) out.addPair(k, b.get(k));
		return out;
	}

	// ISSUE handle keys?
	public static function filter<K, V>(source:IOmap<K, V>, func:V->Bool, out:IOmap<K, V>):IOmap<K, V> {
		for (k in source.keys()) {
			var v:V = source.get(k);
			if (func(v)) out.addPair(k, v);
		}
		return out;
	}

	// ISSUE handle keys?
	// ISSUE map keys?
	public static function map<K, V, W>(source:IOmap<K, V>, func:V->W, out:IOmap<K, W>):IOmap<K, W> {
		for (k in source.keys()) {
			out.addPair(k, func(source.get(k)));
		}
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
