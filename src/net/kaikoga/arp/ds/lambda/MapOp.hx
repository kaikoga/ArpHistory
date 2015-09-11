package net.kaikoga.arp.ds.lambda;

class MapOp {

	public static function copy<T>(a:IMap<T>, out:IMap<T>):IMap<T> {
		return out;
	}

	public static function and<T>(a:IMap<T>, b:IMap<T>, out:IMap<T>):IMap<T> {
		return out;
	}

	public static function or<T>(a:IMap<T>, b:IMap<T>, out:IMap<T>):IMap<T> {
		return out;
	}

	public static function filter<T>(source:IMap<T>, func:T->Bool, out:IMap<T>):IMap<T> {
		return out;
	}

	public static function map<T,S>(source:IMap<T>, func:T->S, out:IMap<S>):IMap<S> {
		return out;
	}

}
