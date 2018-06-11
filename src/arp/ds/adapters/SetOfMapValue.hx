package arp.ds.adapters;

import arp.ds.access.ISetKnit.ISetKnitPin;
import arp.ds.lambda.CollectionTools;
import arp.ds.ISet;
import arp.ds.IMap;

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
	public function toString():String return CollectionTools.setToStringImpl(this);

	public function add(v:V):Void if (!this.map.hasValue(v)) this.map.set(this.autoKey(v), v);

	public function remove(v:V):Bool return this.map.remove(v);
	public function clear():Void this.map.clear();

	//knit
	public function knit():Iterator<ISetKnitPin<V>> return CollectionTools.setKnitImpl(this);
}
