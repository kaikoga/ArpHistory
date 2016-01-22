package net.kaikoga.arp.ds.adapters;

import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.IMap;

class SetOfMapValue<K, V> implements ISet<V> {

	private var map:IMap<K, V>;
	private var autoKey:V->K;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(map:IMap<K, V>, autoKey:V->K) {
		this.map = map;
		this.autoKey = autoKey;
	}

	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:V):Bool return this.map.hasValue(v);
	public function iterator():Iterator<V> return this.map.iterator();
	public function toString():String return this.map.toString();

	public function add(v:V):Void if (!this.map.hasValue(v)) this.map.set(this.autoKey(v), v);

	public function remove(v:V):Bool return this.map.remove(v);
	public function clear():Void this.map.clear();

}
