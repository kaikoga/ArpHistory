package arp.ds.lambda;

import arp.ds.access.ISetAmend.ISetAmendCursor;
import arp.ds.access.IOmapAmend.IOmapAmendCursor;
import arp.ds.access.IMapAmend.IMapAmendCursor;
import arp.ds.access.IListAmend.IListAmendCursor;
import arp.ds.access.IOmapRead;
import arp.ds.access.IListRead;
import arp.ds.access.ISetRead;
import arp.ds.access.IMapRemove;
import arp.ds.access.IListRemove;
import arp.ds.access.ICollectionRemove;
import arp.ds.access.IOmapWrite;
import arp.ds.access.IMapWrite;
import arp.ds.access.IListWrite;
import arp.ds.access.ICollectionRead;
import arp.ds.access.IMapRead;

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

	// IListRead

	inline public static function get_lengthImpl<V>(base:IListRead<V>):Int {
		var i:Int = 0; for (x in base) i++; return i;
	}

	public static function firstImpl<V>(base:IListRead<V>):Null<V> {
		for (x in base) return x; return null;
	}

	inline public static function lastImpl<V>(base:IListRead<V>):Null<V> {
		var v:V = null; for (x in base) v = x; return v;
	}

	public static function getAtImpl<V>(base:IListRead<V>, index:Int):Null<V> {
		var i:Int = 0; for (x in base) if (i++ == index) return x; return null;
	}

	// IMapRead

	inline public static function getImpl<K, V>(base:IMapRead<K, V>, k:K):Null<V> {
		throw "get() is mandatory";
	}

	public static function hasKeyImpl<K, V>(base:IMapRead<K, V>, k:K):Bool {
		throw "hasKey() is mandatory";
	}

	inline public static function keysImpl<K, V>(base:IMapRead<K, V>):Iterator<K> {
		throw "keys() is mandatory";
	}

	// IMapResolve

	public static function resolveNameImpl<K, V>(base:IMapRead<K, V>, v:V):Null<K> {
		for (k in base.keys()) if (base.get(k) == v) return k; return null;
	}

	// IListResolve

	public static function indexOfImpl<V>(base:ICollectionRead<V>, v:V, ?fromIndex:Int):Int {
		var i:Int = 0; for (x in base) if (x == v) return i; else i++; return -1;
	}

	inline public static function lastIndexOfImpl<V>(base:ICollectionRead<V>, v:V, ?fromIndex:Int):Int {
		var i:Int = 0; var index:Int = -1; for (x in base) if (x == v) index = i++; else i++; return index;
	}

	// ISetWrite

	inline public static function addImpl<V>(base:ICollectionRead<V>, value:V):Void {
		throw "add() is mandatory";
	}

	//IListWrite

	inline public static function pushImpl<V>(base:IList<V>, v:V):Int {
		base.insertAt(base.length, v); return base.length;
	}

	inline public static function unshiftImpl<V>(base:IListWrite<V>, v:V):Void {
		return base.insertAt(0, v);
	}

	inline public static function insertImpl<V>(base:IListWrite<V>, index:Int, v:V):Void {
		throw "insert() is mandatory";
	}

	// IMapWrite

	inline public static function setImpl<K, V>(base:IMapWrite<K, V>, k:K, v:V):Void {
		throw "set() is mandatory";
	}

	// IMapListWrite

	inline public static function addPairImpl<K, V>(base:IOmapWrite<K, V>, k:K, v:V):Void {
		throw "addPair() is mandatory";
	}

	inline public static function insertPairAtImpl<K, V>(base:IOmapWrite<K, V>, index:Int, k:K, v:V):Void {
		throw "insertPairAt() is mandatory";
	}

	// ICollectionRemove

	inline public static function clearImpl<V>(base:ICollectionRemove<V>):Void {
		throw "clear() is mandatory";
	}

	inline public static function removeImpl<V>(base:ICollectionRemove<V>, v:V):Bool {
		throw "remove() is mandatory";
	}

	//IListRemove

	inline public static function popImpl<V>(base:IListRemove<V>):Null<V> {
		var i = base.length - 1; var v = base.getAt(i); base.removeAt(i); return v;
	}

	inline public static function shiftImpl<V>(base:IListRemove<V>):Null<V> {
		var v = base.getAt(0); base.removeAt(0); return v;
	}

	inline public static function removeAtImpl<V>(base:IListRemove<V>, index:Int):Bool {
		throw "removeAt() is mandatory";
	}

	// IMapRemove

	inline public static function removeKeyImpl<K, V>(base:IMapRemove<K, V>, k:K):Bool {
		throw "removeKey() is mandatory";
	}

	// toString

	public static function setToStringImpl<V>(base:ISetRead<V>):String {
		var s:Array<String> = [];
		for (v in base) s.push(Std.string(v));
		return '[${s.join(", ")}]';
	}

	public static function listToStringImpl<V>(base:IListRead<V>):String {
		var s:Array<String> = [];
		for (v in base) s.push(Std.string(v));
		return '[${s.join("; ")}]';
	}

	public static function mapToStringImpl<K, V>(base:IMapRead<K, V>):String {
		var s:Array<String> = [];
		for (k in base.keys()) s.push('${Std.string(k)} => ${Std.string(base.get(k))}');
		return '{${s.join(", ")}}';
	}

	public static function omapToStringImpl<K, V>(base:IOmapRead<K, V>):String {
		var s:Array<String> = [];
		for (k in base.keys()) s.push('${Std.string(k)} => ${Std.string(base.get(k))}');
		return '{${s.join("; ")}}';
	}

	// amend

	public static function setAmendImpl<V>(base:ISet<V>):Iterator<ISetAmendCursor<V>> {
		return new ArraySetAmendCursor(base);
	}

	public static function listAmendImpl<V>(base:IList<V>):Iterator<IListAmendCursor<V>> {
		return new ArrayListAmendCursor(base);
	}

	public static function mapAmendImpl<K, V>(base:IMap<K, V>):Iterator<IMapAmendCursor<K, V>> {
		return new ArrayMapAmendCursor(base);
	}

	public static function omapAmendImpl<K, V>(base:IOmap<K, V>):Iterator<IOmapAmendCursor<K, V>> {
		return new ArrayOmapAmendCursor(base);
	}
}

class ArraySetAmendCursor<V> implements ISetAmendCursor<V> {

	private var me:ISet<V>;
	private var values:Array<V>;
	private var readIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:ISet<V>) {
		this.me = me;
		this.values = SetOp.toArray(me);
		this.readIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < values.length;
	inline public function next():ISetAmendCursor<V> { readIndex++; return this; }

	public var value(get, never):V;
	inline private function get_value():V return values[readIndex];

	inline public function insert(v:V):Void me.add(v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.remove(this.value);
	}
}

class ArrayListAmendCursor<V> implements IListAmendCursor<V> {

	private var me:IList<V>;
	private var values:Array<V>;
	private var readIndex:Int;
	private var outIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IList<V>) {
		this.me = me;
		this.values = ListOp.toArray(me);
		this.readIndex = -1;
		this.outIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < values.length;
	inline public function next():IListAmendCursor<V> { readIndex++; outIndex++; return this; }

	public var value(get, never):V;
	inline private function get_value():V return values[readIndex];
	public var index(get, never):Int;
	inline private function get_index():Int return readIndex;

	inline public function prepend(v:V):Void me.insertAt(outIndex++, v);
	inline public function append(v:V):Void me.insertAt(++outIndex, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeAt(outIndex--);
	}
}

class ArrayMapAmendCursor<K, V> implements IMapAmendCursor<K, V> {

	private var me:IMap<K, V>;
	private var keys:Array<K>;
	private var readIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IMap<K, V>) {
		this.me = me;
		this.keys = MapOp.toKeyArray(me);
		this.readIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < keys.length;
	inline public function next():IMapAmendCursor<K, V> { readIndex++; return this; }

	public var key(get, never):K;
	inline private function get_key():K return keys[readIndex];
	public var value(get, never):V;
	inline private function get_value():V return me.get(keys[readIndex]);

	inline public function insert(k:K, v:V):Void me.set(k, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeKey(key);
	}
}

class ArrayOmapAmendCursor<K, V> implements IOmapAmendCursor<K, V> {

	private var me:IOmap<K, V>;
	private var keys:Array<K>;
	private var readIndex:Int;
	private var outIndex:Int;
	private var removedIndex:Int;

	inline public function new(me:IOmap<K, V>) {
		this.me = me;
		this.keys = OmapOp.toKeyArray(me);
		this.readIndex = -1;
		this.outIndex = -1;
		this.removedIndex = -1;
	}

	inline public function hasNext():Bool return readIndex + 1 < keys.length;
	inline public function next():IOmapAmendCursor<K, V> { readIndex++; outIndex++; return this; }

	public var key(get, never):K;
	inline private function get_key():K return keys[readIndex];
	public var value(get, never):V;
	inline private function get_value():V return me.get(keys[readIndex]);
	public var index(get, never):Int;
	inline private function get_index():Int return readIndex;

	inline public function prepend(k:K, v:V):Void me.insertPairAt(outIndex++, k, v);
	inline public function append(k:K, v:V):Void me.insertPairAt(++outIndex, k, v);
	inline public function remove():Bool {
		if (removedIndex == readIndex) throw "invalid operation";
		removedIndex = readIndex;
		return me.removeAt(outIndex--);
	}
}
