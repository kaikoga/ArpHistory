package net.kaikoga.arp.ds.lambda;

class ListOp {

	public static function copy<T>(a:IList<T>, out:IList<T>):IList<T> {
		return out;
	}

	public static function and<T>(a:IList<T>, b:IList<T>, out:IList<T>):IList<T> {
		return out;
	}

	public static function or<T>(a:IList<T>, b:IList<T>, out:IList<T>):IList<T> {
		return out;
	}

	public static function filter<T>(source:IList<T>, func:T->Bool, out:IList<T>):IList<T> {
		return out;
	}

	public static function map<T,S>(source:IList<T>, func:T->S, out:IList<S>):IList<S> {
		return out;
	}

}
