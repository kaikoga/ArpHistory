package net.kaikoga.arp.ds.access;

interface ISetKnit<V> extends ISetRead<V> {
	function knit():Iterator<ISetKnitPin<V>>;
}

interface ISetKnitPin<V> {
	var value(get, never):V;

	function insert(v:V):Void;
	function remove():Bool;
}
