package net.kaikoga.arp.ds;

interface IList<T> extends IListBase<T> {
	function pop():Null<T>;
	function push(x:T):Int;
	function shift():Null<T>;
	function unshift(x:T):Void;
	function insert(pos:Int, x:T):Void;
	function remove(pos:Int):Void;
}
