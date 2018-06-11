package arp.ds.access;

interface IListKnit<V> extends IListRead<V> {
	function knit():Iterator<IListKnitPin<V>>;
}

interface IListKnitPin<V> {
	var index(get, never):Int;
	var value(get, never):V;

	function prepend(v:V):Void;
	function append(v:V):Void;
	function remove():Bool;
}
