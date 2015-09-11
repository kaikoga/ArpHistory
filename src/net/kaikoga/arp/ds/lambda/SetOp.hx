package net.kaikoga.arp.ds.lambda;

class SetOp {

	public static function copy<T>(a:ISet<T>, out:ISet<T>):ISet<T> {
		return out;
	}

	public static function and<T>(a:ISet<T>, b:ISet<T>, out:ISet<T>):ISet<T> {
		return out;
	}

	public static function or<T>(a:ISet<T>, b:ISet<T>, out:ISet<T>):ISet<T> {
		return out;
	}

	public static function filter<T>(source:ISet<T>, func:T->Bool, out:ISet<T>):ISet<T> {
		return out;
	}

	public static function map<T,S>(source:ISet<T>, func:T->S, out:ISet<S>):ISet<S> {
		return out;
	}

}
