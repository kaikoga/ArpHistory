package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.iter.EmptyIterator;
import net.kaikoga.arp.ds.ISet;

class VoidSet<V> implements ISet<V> {

	public function new() return;

	// read
	public function isEmpty():Bool return false;
	public function hasValue(value:V):Bool return false;
	public function iterator():Iterator<V> return new EmptyIterator();
	public function toString():String return "";

	// write
	public function add(value:V):Void return;
	public function remove(v:V):Bool return false;
	public function clear():Void return;
}
