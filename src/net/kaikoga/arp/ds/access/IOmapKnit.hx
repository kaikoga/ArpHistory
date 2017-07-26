package net.kaikoga.arp.ds.access;

interface IOmapKnit<K, V> extends IOmapRead<K, V> {
	function knit():Iterator<IOmapKnitPin<K, V>>;
}

interface IOmapKnitPin<K, V> {
	public function key():K;
	public function value():V;
	public function prepend(k:K, v:V):Void;
	public function append(k:K, v:V):Void;
	public function remove():Bool;
}
