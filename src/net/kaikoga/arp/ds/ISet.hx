package net.kaikoga.arp.ds;

interface ISet<T> extends ICollection<T> {
	function add(value:T):Void;
	function remove(v:T):Bool;
}
