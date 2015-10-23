package net.kaikoga.arp.ds.lambda;

class ListOp {

	public static function copy<V>(a:IList<V>, out:IList<V>):IList<V> {
		return out;
	}

	public static function and<V>(a:IList<V>, b:IList<V>, out:IList<V>):IList<V> {
		return out;
	}

	public static function or<V>(a:IList<V>, b:IList<V>, out:IList<V>):IList<V> {
		return out;
	}

	public static function filter<V>(source:IList<V>, func:V->Bool, out:IList<V>):IList<V> {
		return out;
	}

	public static function map<V, W>(source:IList<V>, func:V->W, out:IList<W>):IList<W> {
		return out;
	}

	public static function bulkPush<V>(target:IList<V>, source:IList<V>):IList<V> {
		for (v in source) target.push(v);
		return target;
	}

	public static function bulkPushArray<V>(target:IList<V>, source:Array<V>):IList<V> {
		for (v in source) target.push(v);
		return target;
	}

	public static function toArray<V>(source:IList<V>):Array<V> {
		return [for (v in source) v];
	}

	public static function toAnon(source:IList<String>):Dynamic {
		var anon:Dynamic = {};
		for (v in source) Reflect.setField(anon, v, v);
		return anon;
	}
}
