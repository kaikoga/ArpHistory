package net.kaikoga.arp.ds.access;

interface IOmapKnit<K, V> extends IOmapRead<K, V> {
	function knit():Iterator<IOmapKnitPin<K, V>>;
}

interface IOmapKnitPin<K, V> {
	var index(get, never):Int;
	var key(get, never):K;
	var value(get, never):V;

	function prepend(k:K, v:V):Void;
	function append(k:K, v:V):Void;
	function remove():Bool;
}
