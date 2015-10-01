package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.IMapList;

@:generic @:remove
class StdMapList<K, V> implements IMapList<K, V> {

	private var value:Map<K, V>;

	public function new() this.value = new Map();

	//read
	public function isEmpty():Bool return Lambda.empty({iterator:function() return this.value.iterator()});
	public function hasValue(v:V):Bool return Lambda.has({iterator:function() return this.value.iterator()}, v);
	public function iterator():Iterator<V> return this.value.iterator();
	public function toString():String return this.value.toString();
	public function get(k:K):Null<V> return this.value.get(k);
	public function hasKey(k:K):Bool return this.value.exists(k);
	public function keys():Iterator<K> return this.value.keys();
	public var length(get, null):Int;
	public function get_length():Int return 0;
	public function first():Null<V> return null;
	public function last():Null<V> return null;
	public function getAt(index:Int):Null<V> return null;

	//resolve
	public function resolveKeyIndex(k:K):Int return -1;
	public function resolveName(v:V):Null<K> {
		for (k in this.value.keys()) if (this.value.get(k) == v) return k;
		return null;
	}
	public function indexOf(v:V, ?fromIndex:Int):Int return -1;
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return -1;

	//write
	public function addPair(k:K, v:V):Void this.value.set(k, v);
	public function insertPairAt(index:Int, k:K, v:V):Void this.value.set(k, v);
	public function remove(v:V):Bool this.value.remove(this.resolveName(v));
	public function removeKey(k:K):Bool this.value.remove(k);
	public function removeAt(index:Int):Bool throw "implementing";
	public function clear():Void this.value = new Map();

}
