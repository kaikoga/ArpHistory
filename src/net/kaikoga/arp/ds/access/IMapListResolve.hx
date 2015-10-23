package net.kaikoga.arp.ds.access;

interface IMapListResolve<K, V> extends IMapListWrite<K, V> extends IMapResolve<K, V>  extends IListResolve<V> {
	function resolveKeyIndex(k:K):Int;
}
