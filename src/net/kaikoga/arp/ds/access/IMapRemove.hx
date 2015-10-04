package net.kaikoga.arp.ds.access;

interface IMapRemove<K, V> extends ICollectionRemove<V> extends IMapRead<K, V> {
	public function removeKey(k:K):Bool;
}
