package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.IMap;

@:generic @:remove
class StdMapList<K, V> implements IMap<K, V> {

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
	public function set(k:K, v:V):Void this.value.set(k, v);
	public function remove(k:K):Bool return this.value.remove(k);
	public function pop():Null<V> return null;
	public function push(v:V):Int return 0;
	public function shift():Null<V> return null;
	public function unshift(v:V):Void return;
	public function insertAt(index:Int, v:V):Void return;
	public function removeAt(index:Int):Void return;
	public function clear():Void this.value = new Map<K, V>();

}
