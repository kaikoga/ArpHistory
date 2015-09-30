package net.kaikoga.arp.ds.impl.base;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.iter.EmptyIterator;
import net.kaikoga.arp.ds.IMap;

class BaseMap<K, V> implements IMap<K, V> {

	public function new() return;

	//read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.toStringImpl(this);
	public function get(k:K):Null<V> return null;
	public function hasKey(key:K):Bool return false;
	public function keys():Iterator<K> return new EmptyIterator();

	//resolve
	public function resolveName(v:V):Null<K> return null;

	//write
	public function set(k:K, v:V):Void return;
	public function remove(k:K):Bool return false;
	public function clear():Void CollectionTools.clearImpl(this);
}
