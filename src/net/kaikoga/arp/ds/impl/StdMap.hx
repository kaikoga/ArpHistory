package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.access.IMapKnit.IMapKnitPin;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.lambda.CollectionTools;

@:generic @:remove
class StdMap<K, V> implements IMap<K, V> {

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	private var value:Map<K, V>;

	public function new() this.value = new Map<K, V>();

	//read
	public function isEmpty():Bool return !this.value.iterator().hasNext();
	public function hasValue(v:V):Bool { for (x in this.value) if (x == v) return true; return false; }
	public function iterator():Iterator<V> return this.value.iterator();
	public function toString():String return CollectionTools.mapToStringImpl(this);
	public function get(k:K):Null<V> return this.value.get(k);
	public function hasKey(k:K):Bool return this.value.exists(k);
	public function keys():Iterator<K> return this.value.keys();

	//resolve
	public function resolveName(v:V):Null<K> {
		for (k in this.value.keys()) if (this.value.get(k) == v) return k;
		return null;
	}

	//write
	public function set(k:K, v:V):Void this.value.set(k, v);

	//remove
	public function remove(v:V):Bool {
		var k:Null<K> = this.resolveName(v);
		return if (k != null) this.value.remove(k) else false;
	}
	public function removeKey(k:K):Bool return this.value.remove(k);
	public function clear():Void this.value = new Map<K, V>();

	// knit
	public function knit():Iterator<IMapKnitPin<K, V>> return CollectionTools.mapKnitImpl(this);
}
