package net.kaikoga.arp.domain.ds;

interface ICollection<T> {
	function isEmpty():Bool;
	function clear():Void;
	function exists(item:T):Bool;
	function iterator():Iterator<V>;
	function toString():String;
}
