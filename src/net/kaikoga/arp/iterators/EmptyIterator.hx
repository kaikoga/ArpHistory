package net.kaikoga.arp.iterators;

class EmptyIterator<T> {
	public function new() return;
	public function hasNext():Bool return false;
	public function next():T return cast null;
}
