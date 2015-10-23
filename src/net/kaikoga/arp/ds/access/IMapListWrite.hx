package net.kaikoga.arp.ds.access;

interface IMapListWrite<K, V> extends ICollectionWrite<V> {
	function addPair(k:K, v:V):Void;
	function insertPairAt(index:Int, k:K, v:V):Void;
}
