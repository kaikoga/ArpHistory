package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.access.ICollectionWrite;
import net.kaikoga.arp.ds.access.IListWrite;
import net.kaikoga.arp.ds.access.ICollectionRead;
import net.kaikoga.arp.ds.access.IMapRead;

@:remove
class CollectionTools {

	// ICollectionRead

	inline public static function isEmptyImpl<V>(base:ICollectionRead<V>):Bool {
		return !base.iterator().hasNext();
	}

	public static function hasValueImpl<V>(base:ICollectionRead<V>, v:V):Bool {
		for (x in base) if (x == v) return true; return false;
	}

	inline public static function iteratorImpl<V>(base:ICollectionRead<V>):Iterator<V> {
		throw "iterator() is mandatory";
	}

	inline public static function toStringImpl<V>(base:ICollectionRead<V>):String {
		var s:Array<String> = []; for (v in base) s.push(Std.string(v)); return s.join(",");
	}

	// IListRead
	inline public static function get_lengthImpl<V>(base:ICollectionRead<V>):Int {
		var i:Int = 0; for (x in base) i++; return i;
	}

	public static function firstImpl<V>(base:ICollectionRead<V>):Null<V> {
		for (x in base) return x; return null;
	}

	inline public static function lastImpl<V>(base:ICollectionRead<V>):Null<V> {
		var v:V = null; for (x in base) v = x; return v;
	}

	public static function getAtImpl<V>(base:ICollectionRead<V>, index:Int):Null<V> {
		var i:Int = 0; for (x in base) if (i++ == index) return x; return null;
	}

	// IMapResolve

	inline public static function resolveNameImpl<K, V>(base:IMapRead<K, V>, v:V):Null<K> {
		for (k in base.keys()) if (base.get(k) == v) return k; return null;
	}

	// IListResolve

	public static function indexOfImpl<V>(base:ICollectionRead<V>, v:V, ?fromIndex:Int):Int {
		var i:Int = 0; for (x in base) if (x == v) return i; else i++; return -1;
	}

	inline public static function lastIndexOfImpl<V>(base:ICollectionRead<V>, v:V, ?fromIndex:Int):Int {
		var i:Int = 0; var index:Int = -1; for (x in base) if (x == v) index = i++; return index;
	}

	// ICollectionWrite

	inline public static function clearImpl<V>(base:ICollectionWrite<V>):Void {
		throw "clear() is mandatory";
	}

	// ISetWrite

	inline public static function addImpl<V>(base:ICollectionRead<V>, value:V):Void {
		throw "add() is mandatory";
	}

	inline public static function removeImpl<V>(base:ICollectionRead<V>, v:V):Bool {
		throw "remove() is mandatory";
	}

	//IListWrite

	inline public static function popImpl<V>(base:IList<V>):Null<V> {
		var i = base.length - 1; var v = base.getAt(i); base.removeAt(i); return v;
	}

	inline public static function pushImpl<V>(base:IList<V>, v:V):Int {
		base.insertAt(base.length, v); return base.length;
	}

	inline public static function shiftImpl<V>(base:IList<V>):Null<V> {
		var v = base.getAt(0); base.removeAt(0); return v;
	}

	inline public static function unshiftImpl<V>(base:IListWrite<V>, v:V):Void {
		return base.insertAt(0, v);
	}

	inline public static function insertImpl<V>(base:IListWrite<V>, index:Int, v:V):Void {
		throw "insert() is mandatory";
	}

	inline public static function removeAtImpl<V>(base:IListWrite<V>, index:Int):Void {
		throw "removeAt() is mandatory";
	}

}

