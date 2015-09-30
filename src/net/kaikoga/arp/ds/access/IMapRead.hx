package net.kaikoga.arp.ds.access;

interface IMapRead<K, V> extends ICollectionRead<V> {
	public function get(k:K):Null<V>;
	public function hasKey(k:K):Bool;
	public function keys():Iterator<K>;
}
