package net.kaikoga.arp.ds.access;

interface IMapWrite<K, V> extends ICollectionWrite<K> {
	public function set(k:K, v:V):Void;
	public function exists(k:K):Bool;
	public function remove(k:K):Bool;
}
