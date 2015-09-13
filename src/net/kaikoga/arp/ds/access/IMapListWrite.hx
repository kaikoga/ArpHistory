package net.kaikoga.arp.ds.access;

interface IMapListWrite<K, V> extends ICollectionWrite<T> {
	public function set(k:K, v:V):Void;
	public function exists(k:K):Bool;
	public function remove(k:K):Bool;

	function pop():Null<T>;
	function push(x:T):Int;
	function shift():Null<T>;
	function unshift(x:T):Void;
	function insert(pos:Int, x:T):Void;
	function remove(pos:Int):Void;
}
