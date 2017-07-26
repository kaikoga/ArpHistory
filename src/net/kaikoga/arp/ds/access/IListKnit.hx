package net.kaikoga.arp.ds.access;

interface IListKnit<V> extends IListRead<V> {
	function knit():Iterator<IListKnitPin<V>>;
}

interface IListKnitPin<V> {
	public function value():V;
	public function prepend(v:V):Void;
	public function append(v:V):Void;
	public function remove():Bool;
}
