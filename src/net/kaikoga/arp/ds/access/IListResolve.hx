package net.kaikoga.arp.ds.access;

interface IListResolve<T> extends IListRead<T> {
	function indexOf(x:T, ?fromIndex:Int):Int;
	function lastIndexOf(x:T, ?fromIndex:Int):Int;
}
