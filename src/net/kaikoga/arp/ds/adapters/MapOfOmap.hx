package net.kaikoga.arp.ds.adapters;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;

class MapOfOmap<K, V> implements IMap<K, V> {

	private var omap:IOmap<K, V>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(omap:IOmap<K, V>) {
		this.omap = omap;
	}

	//read
	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:V):Bool return this.omap.hasValue(v);
	public function iterator():Iterator<V> return this.omap.iterator();
	public function toString():String return this.omap.toString();
	public function get(k:K):Null<V> return this.omap.get(k);
	public function hasKey(k:K):Bool return this.omap.hasKey(k);
	public function keys():Iterator<K> return this.omap.keys();

	//resolve
	public function resolveName(v:V):Null<K> return this.omap.resolveName(v);

	//write
	public function set(k:K, v:V):Void this.omap.addPair(k, v);

	//remove
	public function remove(v:V):Bool return this.omap.remove(v);
	public function removeKey(k:K):Bool return this.omap.removeKey(k);
	public function clear():Void this.omap.clear();

}
