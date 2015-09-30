package net.kaikoga.arp.ds.impl.base;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.iter.EmptyIterator;
import net.kaikoga.arp.ds.IMapList;

class BaseMapList<K, V> implements IMapList<K, V> {

	public function new() return;

	//read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.toStringImpl(this);
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
	public function set(k:K, v:V):Void return;
	public function remove(k:K):Bool return false;
	public function pop():Null<V> return null;
	public function push(v:V):Int return 0;
	public function shift():Null<V> return null;
	public function unshift(v:V):Void return;
	public function insertAt(index:Int, v:V):Void return;
	public function removeAt(index:Int):Void return;
	public function clear():Void CollectionTools.clearImpl(this);
}
