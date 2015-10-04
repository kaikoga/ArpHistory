package net.kaikoga.arp.ds.access;

interface IMapWrite<K, V> extends ICollectionWrite<K> {
	public function set(k:K, v:V):Void;
}
