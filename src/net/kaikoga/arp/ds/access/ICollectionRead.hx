package net.kaikoga.arp.ds.access;

interface ICollectionRead<V> {
	function isEmpty():Bool;
	function hasValue(v:V):Bool;
	function iterator():Iterator<V>;
	function toString():String;
}
