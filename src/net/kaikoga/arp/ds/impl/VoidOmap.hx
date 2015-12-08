package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.iter.EmptyIterator;
import net.kaikoga.arp.ds.IOmap;

class VoidOmap<K, V> implements IOmap<K, V> {

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() return;

	//read
	public function isEmpty():Bool return false;
	public function hasValue(v:V):Bool return false;
	public function iterator():Iterator<V> return new EmptyIterator();
	public function toString():String return "";
	public function get(k:K):Null<V> return null;
	public function hasKey(key:K):Bool return false;
	public function keys():Iterator<K> return new EmptyIterator();
	public var length(get, null):Int;
	public function get_length():Int return 0;
	public function first():Null<V> return null;
	public function last():Null<V> return null;
	public function getAt(index:Int):Null<V> return null;

	//resolve
	public function resolveKeyIndex(k:K):Int return -1;
	public function resolveName(v:V):Null<K> return null;
	public function indexOf(v:V, ?fromIndex:Int):Int return -1;
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return -1;

	//write
	public function addPair(k:K, v:V):Void return;
	public function insertPairAt(index:Int, k:K, v:V):Void return;

	// remove
	public function remove(v:V):Bool return false;
	public function removeKey(k:K):Bool return false;
	public function removeAt(index:Int):Bool return false;
	public function pop():Null<V> return null;
	public function shift():Null<V> return null;
	public function clear():Void return;
}
