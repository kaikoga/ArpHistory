package net.kaikoga.arp.domain.ds;

interface IMapBase<K,V> extends ICollection<V> {
	public function get(k:K):Null<V>;
	public function remove(k:K):Bool;
	public function keys():Iterator<K>;
}
