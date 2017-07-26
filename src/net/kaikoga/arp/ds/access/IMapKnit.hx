package net.kaikoga.arp.ds.access;

interface IMapKnit<K, V> extends IMapRead<K, V> {
	function knit():Iterator<IMapKnitPin<K, V>>;
}

interface IMapKnitPin<K, V> {
	public function key():K;
	public function value():V;
	public function insert(k:K, v:V):Void;
	public function remove():Bool;
}
