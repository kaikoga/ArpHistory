package net.kaikoga.arp.ds.lambda;

class MapListOp {

	public static function copy<T>(a:IMapList<T>, out:IMapList<T>):IMapList<T> {
		return out;
	}

	public static function and<T>(a:IMapList<T>, b:IMapList<T>, out:IMapList<T>):IMapList<T> {
		return out;
	}

	public static function or<T>(a:IMapList<T>, b:IMapList<T>, out:IMapList<T>):IMapList<T> {
		return out;
	}

	public static function filter<T>(source:IMapList<T>, func:T->Bool, out:IMapList<T>):IMapList<T> {
		return out;
	}

	public static function map<T,S>(source:IMapList<T>, func:T->S, out:IMapList<S>):IMapList<S> {
		return out;
	}

}
