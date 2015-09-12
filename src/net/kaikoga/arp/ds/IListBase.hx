package net.kaikoga.arp.ds;

interface IListBase<T> extends ICollection<T> {

	var length(default, null):Int;
	function first():Null<T>;
	function last():Null<T>;
	function indexOf(x:T, ?fromIndex:Int):Int;
	function lastIndexOf(x:T, ?fromIndex:Int):Int;

}
