package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.ISet;

class ArraySet<V> implements ISet<V> {

	private var value:Array<V>;

	public function new() {
		this.value = [];
	}

	//read
	public function isEmpty():Bool return this.value.length == 0;
	public function hasValue(v:V):Bool return this.value.indexOf(v) >= 0;
	public function iterator():Iterator<V> return this.value.iterator();
	public function toString():String return this.value.toString();

	//write
	public function add(v:V):Void this.value.push(v);

	//remove
	public function remove(v:V):Bool return this.value.remove(v);
	public function clear():Void this.value = [];
}
