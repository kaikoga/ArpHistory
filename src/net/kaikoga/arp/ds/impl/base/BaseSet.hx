package net.kaikoga.arp.ds.impl.base;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;

class BaseSet<V> implements ISet<V> {

	public function new() return;

	// read
	public function isEmpty():Bool return CollectionTools.isEmptyImpl(this);
	public function hasValue(v:V):Bool return CollectionTools.hasValueImpl(this, v);
	public function iterator():Iterator<V> return CollectionTools.iteratorImpl(this);
	public function toString():String return CollectionTools.toStringImpl(this);

	// write
	public function add(v:V):Void CollectionTools.addImpl(this, v);
	public function remove(v:V):Bool return CollectionTools.removeImpl(this, v);
	public function clear():Void CollectionTools.clearImpl(this);
}
