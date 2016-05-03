package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.domain.ArpSlot;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IMap;

@:generic @:remove
class ArpObjectMap<K, V:IArpObject> implements IMap<K, V> {

	private var slotMap:IMap<K, ArpSlot<V>>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() this.slotMap = new StdMap<K, ArpSlot<V>>();

	//read
	public function isEmpty():Bool return this.slotMap.isEmpty();
	public function hasValue(v:V):Bool return this.slotMap.hasValue(v.arpSlot());
	public function iterator():Iterator<V> return new ArpObjectIterator(this.slotMap.iterator());
	public function toString():String return CollectionTools.mapToStringImpl(this);
	public function get(k:K):Null<V> return this.slotMap.hasKey(k) ? this.slotMap.get(k).value : null;
	public function hasKey(k:K):Bool return this.slotMap.hasKey(k);
	public function keys():Iterator<K> return this.slotMap.keys();

	//resolve
	public function resolveName(v:V):Null<K> return this.slotMap.resolveName(v.arpSlot());

	//write
	public function set(k:K, v:V):Void this.slotMap.set(k, v.arpSlot());

	//remove
	public function remove(v:V):Bool return this.slotMap.remove(v.arpSlot());
	public function removeKey(k:K):Bool return this.slotMap.removeKey(k);
	public function clear():Void this.slotMap.clear();
}
