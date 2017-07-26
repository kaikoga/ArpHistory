package net.kaikoga.arp.ds.access;

interface ISetKnit<V> extends ISetRead<V> {
	function knit():Iterator<ISetKnitPin<V>>;
}

interface ISetKnitPin<V> {
	public function value():V;
	public function insert(v:V):Void;
	public function remove():Bool;
}
