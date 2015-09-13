package net.kaikoga.arp.ds.access;

interface IListWrite<T> extends ICollectionWrite<T> {
	function pop():Null<T>;
	function push(x:T):Int;
	function shift():Null<T>;
	function unshift(x:T):Void;
	function insert(pos:Int, x:T):Void;
	function remove(pos:Int):Void;
}
