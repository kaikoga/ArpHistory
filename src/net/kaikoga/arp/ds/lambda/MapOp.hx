package net.kaikoga.arp.ds.lambda;

class MapOp {

	public static function copy<K, V>(a:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		for (k in a.keys()) out.set(k, a.get(k));
		return out;
	}

	public static function and<K, V>(a:IMap<K, V>, b:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		for (k in a.keys()) if (b.hasKey(k)) out.set(k, a.get(k));
		return out;
	}

	public static function or<K, V>(a:IMap<K, V>, b:IMap<K, V>, out:IMap<K, V>):IMap<K, V> {
		for (k in a.keys()) out.set(k, a.get(k));
		for (k in b.keys()) if (!a.hasKey(k)) out.set(k, b.get(k));
		return out;
	}

	// ISSUE handle keys?
	public static function filter<K, V>(source:IMap<K, V>, func:V->Bool, out:IMap<K, V>):IMap<K, V> {
		for (k in source.keys()) {
			var v:V = source.get(k);
			if (func(v)) out.set(k, v);
		}
		return out;
	}

	// ISSUE handle keys?
	// ISSUE map keys?
	public static function map<K, V, W>(source:IMap<K, V>, func:V->W, out:IMap<K, W>):IMap<K, W> {
		for (k in source.keys()) {
			out.set(k, func(source.get(k)));
		}
		return out;
	}

	public static function bulkSet<K, V>(target:IMap<K, V>, source:IMap<K, V>):IMap<K, V> {
		for (k in source.keys()) target.set(k, source.get(k));
		return target;
	}

	public static function bulkSetAnon<V>(target:IMap<String, V>, source:Dynamic):IMap<String, V> {
		for (k in Reflect.fields(source)) target.set(k, Reflect.field(source, k));
		return target;
	}

	public static function toKeyArray<K, V>(source:IMap<K, V>):Array<K> {
		return [for (k in source.keys()) k];
	}

	public static function toArray<K, V>(source:IMap<K, V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon<V>(source:IMap<String, V>):Dynamic {
		var anon:Dynamic = {};
		for (k in source.keys()) Reflect.setField(anon, k, source.get(k));
		return anon;
	}
}
