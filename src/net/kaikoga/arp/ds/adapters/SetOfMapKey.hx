package net.kaikoga.arp.ds.adapters;

import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.IMap;

class SetOfMapKey<K, V> implements ISet<K> {

	private var map:IMap<K, V>;
	private var autoValue:K->V;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(map:IMap<K, V>, autoValue:K->V) {
		this.map = map;
		this.autoValue = autoValue;
	}

	public function isEmpty():Bool return this.map.isEmpty();
	public function hasValue(v:K):Bool return this.map.hasKey(v);
	public function iterator():Iterator<K> return this.map.keys();
	public function toString():String return CollectionTools.setToStringImpl(this);

	public function add(v:K):Void if (!this.map.hasKey(v)) this.map.set(v, this.autoValue(v));

	public function remove(v:K):Bool return this.map.removeKey(v);
	public function clear():Void this.map.clear();

}
