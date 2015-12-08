package net.kaikoga.arp.ds.access;

interface IOmapResolve<K, V> extends IOmapWrite<K, V> extends IMapResolve<K, V>  extends IListResolve<V> {
	function resolveKeyIndex(k:K):Int;
}
