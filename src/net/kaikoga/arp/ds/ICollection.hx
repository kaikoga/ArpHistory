package net.kaikoga.arp.ds;

interface ICollection<T> {
	function isEmpty():Bool;
	function clear():Void;
	function remove(v:T):Bool;
	function exists(item:T):Bool;
	function iterator():Iterator<V>;
	function toString():String;
}
