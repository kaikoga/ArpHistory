package net.kaikoga.arp.ds.lambda;

class SetOp {

	public static function copy<V>(a:ISet<V>, out:ISet<V>):ISet<V> {
		return out;
	}

	public static function and<V>(a:ISet<V>, b:ISet<V>, out:ISet<V>):ISet<V> {
		return out;
	}

	public static function or<V>(a:ISet<V>, b:ISet<V>, out:ISet<V>):ISet<V> {
		return out;
	}

	public static function filter<V>(source:ISet<V>, func:V->Bool, out:ISet<V>):ISet<V> {
		return out;
	}

	public static function map<V, W>(source:ISet<V>, func:V->W, out:ISet<W>):ISet<W> {
		return out;
	}

	public static function bulkAdd<V>(target:ISet<V>, source:ISet<V>):ISet<V> {
		for (v in source) target.add(v);
		return target;
	}

	public static function bulkAddArray<V>(source:ISet<V>, values:Array<V>):ISet<V> {
		for (v in values) source.add(v);
		return source;
	}

	public static function toArray<V>(source:ISet<V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon(source:ISet<String>):Dynamic {
		var anon:Dynamic = {};
		for (v in source) Reflect.setField(anon, v, v);
		return anon;
	}

}
