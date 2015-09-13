package net.kaikoga.arp.ds.access;

interface IListRead<T> extends ICollectionRead<T> {
	var length(default, null):Int;
	function first():Null<T>;
	function last():Null<T>;
	function getAt(x:Int):Null<T>;
}
