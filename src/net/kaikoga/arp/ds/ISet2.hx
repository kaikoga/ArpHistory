package net.kaikoga.arp.ds;

interface ISet2<T> extends ICollection<T> {
	function add(value:T):Void;
	function and(other:ISet2<T>):ISet2<T>;
	function or(other:ISet2<T>):ISet2<T>;
}
