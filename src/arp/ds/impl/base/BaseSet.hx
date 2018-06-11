package arp.ds.impl.base;

import arp.ds.access.ISetKnit.ISetKnitPin;
import arp.ds.ISet;
import arp.ds.lambda.CollectionTools;

class BaseSet<V> implements ISet<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new() return;

	// read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:V):Void CollectionTools.addImpl(this, v);

	// remove
	public function remove(v:V):Bool return CollectionTools.removeImpl(this, v);
	public function clear():Void CollectionTools.clearImpl(this);

	// knit
	public function knit():Iterator<ISetKnitPin<V>> return CollectionTools.setKnitImpl(this);
}
