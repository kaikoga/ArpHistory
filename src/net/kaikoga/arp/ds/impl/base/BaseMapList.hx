package net.kaikoga.arp.ds.impl.base;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IMapList;

class BaseMapList<K, V> implements IMapList<K, V> {

	public function new() return;

	//read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.toStringImpl(this);
	public function get(k:K):Null<V> return CollectionTools.getImpl(this, k);
	public function hasKey(k:K):Bool return CollectionTools.hasKeyImpl(this, k);
	public function keys():Iterator<K> return CollectionTools.keysImpl(this);
	public var length(get, null):Int;
	public function get_length():Int return CollectionTools.get_lengthImpl(this);
	public function first():Null<V> return CollectionTools.firstImpl(this);
	public function last():Null<V> return CollectionTools.lastImpl(this);
	public function getAt(index:Int):Null<V> return CollectionTools.getAtImpl(this, index);

	//resolve
	public function resolveKeyIndex(k:K):Int return -1;
	public function resolveName(v:V):Null<K> return CollectionTools.resolveNameImpl(this, v);
	public function indexOf(v:V, ?fromIndex:Int):Int return CollectionTools.indexOfImpl(this, v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return CollectionTools.lastIndexOfImpl(this, v, fromIndex);

	//write
	public function addPair(k:K, v:V):Void CollectionTools.addPairImpl(this, k, v);
	public function insertPairAt(index:Int, k:K, v:V):Void CollectionTools.insertPairAtImpl(this, index, k, v);

	//remove
	public function remove(v:V):Bool return CollectionTools.removeImpl(this, v);
	public function removeKey(k:K):Bool return CollectionTools.removeKeyImpl(this, k);
	public function removeAt(index:Int):Bool return CollectionTools.removeAtImpl(this, index);
	public function pop():Null<V> return CollectionTools.popImpl(this);
	public function shift():Null<V> return CollectionTools.shiftImpl(this);
	public function clear():Void CollectionTools.clearImpl(this);

}
