package net.kaikoga.arp.ds;

interface ICollection<T> {
	function isEmpty():Bool;
	function clear():Void;
	function hasValue(item:T):Bool;
	function iterator():Iterator<V>;
	function toString():String;
}
