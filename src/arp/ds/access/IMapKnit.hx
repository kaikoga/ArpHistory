package arp.ds.access;

interface IMapKnit<K, V> extends IMapRead<K, V> {
	function knit():Iterator<IMapKnitPin<K, V>>;
}

interface IMapKnitPin<K, V> {
	var key(get, never):K;
	var value(get, never):V;

	function insert(k:K, v:V):Void;
	function remove():Bool;
}
