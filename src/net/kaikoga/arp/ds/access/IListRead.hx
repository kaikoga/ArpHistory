package net.kaikoga.arp.ds.access;

interface IListRead<V> extends ICollectionRead<V> {
	var length(get, null):Int;
	function get_length():Int;
	function first():Null<V>;
	function last():Null<V>;
	function getAt(index:Int):Null<V>;
}
