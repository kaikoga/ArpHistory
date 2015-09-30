package net.kaikoga.arp.ds.access;

interface IListWrite<V> extends ICollectionWrite<V> {
	function pop():Null<V>;
	function push(v:V):Int;
	function shift():Null<V>;
	function unshift(v:V):Void;
	function insertAt(index:Int, v:V):Void;
	function removeAt(index:Int):Void;
}
