package net.kaikoga.arp.ds;

interface IMapBase<K, V> extends ICollection<V> {
	public function get(k:K):Null<V>;
	public function keys():Iterator<K>;
}
