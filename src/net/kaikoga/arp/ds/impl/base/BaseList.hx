package net.kaikoga.arp.ds.impl.base;

import net.kaikoga.arp.ds.access.IListKnit.IListKnitPin;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.lambda.CollectionTools;

class BaseList<V> implements IList<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() return;

	//read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, null):Int;
	public function get_length():Int return CollectionTools.get_lengthImpl(this);
	public function first():Null<V> return CollectionTools.firstImpl(this);
	public function last():Null<V> return CollectionTools.lastImpl(this);
	public function getAt(index:Int):Null<V> return CollectionTools.getAtImpl(this, index);

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return CollectionTools.indexOfImpl(this, v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return CollectionTools.lastIndexOfImpl(this, v, fromIndex);

	//write
	public function push(v:V):Int return CollectionTools.pushImpl(this, v);
	public function unshift(v:V):Void CollectionTools.unshiftImpl(this, v);
	public function insertAt(index:Int, v:V):Void CollectionTools.insertImpl(this, index, v);

	//remove
	public function pop():Null<V> return CollectionTools.popImpl(this);
	public function shift():Null<V> return CollectionTools.shiftImpl(this);
	public function remove(v:V):Bool return CollectionTools.removeImpl(this, v);
	public function removeAt(index:Int):Bool return CollectionTools.removeAtImpl(this, index);
	public function clear():Void CollectionTools.clearImpl(this);

	// knit
	public function knit():Iterator<IListKnitPin<V>> return CollectionTools.listKnitImpl(this);
}