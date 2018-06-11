package arp.ds.impl;

import arp.ds.access.ISetKnit.ISetKnitPin;
import arp.ds.ISet;
import arp.iterators.EmptyIterator;

class VoidSet<V> implements ISet<V> {

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new() return;

	// read
	public function isEmpty():Bool return false;
	public function hasValue(v:V):Bool return false;
	public function iterator():Iterator<V> return new EmptyIterator();
	public function toString():String return "";

	// write
	public function add(v:V):Void return;

	// remove
	public function remove(v:V):Bool return false;
	public function clear():Void return;

	// knit
	public function knit():Iterator<ISetKnitPin<V>> return new EmptyIterator();
}
