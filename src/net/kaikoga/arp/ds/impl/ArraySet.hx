package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;

class ArraySet<V> implements ISet<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	private var value:Array<V>;

	public function new() {
		this.value = [];
	}

	//read
	public function isEmpty():Bool return this.value.length == 0;
	public function hasValue(v:V):Bool return this.value.indexOf(v) >= 0;
	public function iterator():Iterator<V> return this.value.iterator();
	public function toString():String return CollectionTools.setToStringImpl(this);

	//write
	public function add(v:V):Void if (this.value.indexOf(v) < 0) this.value.push(v);

	//remove
	public function remove(v:V):Bool return this.value.remove(v);
	public function clear():Void this.value = [];
}
