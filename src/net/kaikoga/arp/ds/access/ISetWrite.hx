package net.kaikoga.arp.ds.access;

interface ISetWrite<V> extends ICollectionWrite<V> {
	function add(v:V):Void;
	function remove(v:V):Bool;
}
