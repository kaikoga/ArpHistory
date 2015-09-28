package net.kaikoga.arp.ds.access;

interface IMapResolve<K, V> extends IMapRead<K, V> {
	public function resolveName(v:V):Null<K>;
}
