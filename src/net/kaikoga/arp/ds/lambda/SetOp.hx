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

}
