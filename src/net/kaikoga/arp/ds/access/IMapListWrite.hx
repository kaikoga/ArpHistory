package net.kaikoga.arp.ds.access;

interface IMapListWrite<K, V> extends ICollectionWrite<V> {
	public function set(k:K, v:V):Void;
	public function remove(k:K):Bool;

	public function pop():Null<V>;
	public function push(v:V):Int;
	public function shift():Null<V>;
	public function unshift(v:V):Void;
	public function insertAt(pos:Int, v:V):Void;
	public function removeAt(pos:Int):Void;
}
