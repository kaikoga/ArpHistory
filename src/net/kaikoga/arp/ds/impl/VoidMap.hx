package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.iter.EmptyIterator;
import net.kaikoga.arp.ds.IMap;

class VoidMap<K, V> implements IMap<K, V> {

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

	//resolve
	public function resolveName(v:V):Null<K> return null;

	//write
	public function set(k:K, v:V):Void return;

	//remove
	public function remove(v:V):Bool return false;
	public function removeKey(k:K):Bool return false;
	public function clear():Void return;

}