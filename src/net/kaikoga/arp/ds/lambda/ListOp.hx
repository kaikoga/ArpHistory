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

}
