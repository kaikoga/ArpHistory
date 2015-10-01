package net.kaikoga.arp.ds.access;

interface IMapListWrite<K, V> extends ICollectionWrite<V> {
	public function addPair(k:K, v:V):Void;
	public function insertPairAt(index:Int, k:K, v:V):Void;
	public function removeKey(k:K):Bool;
	public function removeAt(index:Int):Bool;
}
