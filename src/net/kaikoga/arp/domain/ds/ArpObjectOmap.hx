package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.ds.impl.StdOmap;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IOmap;

@:generic @:remove
class ArpObjectOmap<K, V:IArpObject> implements IOmap<K, V> {

	public var slotOmap(default, null):IOmap<K, ArpSlot<V>>;

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new() this.slotOmap = new StdOmap<K, ArpSlot<V>>();

	//read
	public function isEmpty():Bool return this.slotOmap.isEmpty();
	public function hasValue(v:V):Bool return this.slotOmap.hasValue(v.arpSlot());
	public function iterator():Iterator<V> return new ArpObjectIterator(this.slotOmap.iterator());
	public function toString():String return CollectionTools.omapToStringImpl(this);
	public function get(k:K):Null<V> return this.slotOmap.hasKey(k) ? this.slotOmap.get(k).value : null;
	public function hasKey(k:K):Bool return this.slotOmap.hasKey(k);
	public function keys():Iterator<K> return this.slotOmap.keys();
	public var length(get, null):Int;
	public function get_length():Int return this.slotOmap.length;
	public function first():Null<V> return this.slotOmap.isEmpty() ? null : this.slotOmap.first().value;
	public function last():Null<V> return this.slotOmap.isEmpty() ? null : this.slotOmap.last().value;
	public function getAt(index:Int):Null<V> {
		var slot:ArpSlot<V> = this.slotOmap.getAt(index);
		return (slot == null) ? null : slot.value;
	}

	//resolve
	public function resolveKeyIndex(k:K):Int return this.slotOmap.resolveKeyIndex(k);
	public function resolveName(v:V):Null<K> return this.slotOmap.resolveName(v.arpSlot());
	public function indexOf(v:V, ?fromIndex:Int):Int return this.slotOmap.indexOf(v.arpSlot(), fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.slotOmap.lastIndexOf(v.arpSlot(), fromIndex);

	//write
	public function addPair(k:K, v:V):Void this.slotOmap.addPair(k, v.arpSlot());
	public function insertPairAt(index:Int, k:K, v:V):Void this.slotOmap.insertPairAt(index, k, v.arpSlot());

	// remove
	public function remove(v:V):Bool return this.slotOmap.remove(v.arpSlot());
	public function removeKey(k:K):Bool return this.slotOmap.removeKey(k);
	public function removeAt(index:Int):Bool return this.slotOmap.removeAt(index);
	public function pop():Null<V> return this.slotOmap.isEmpty() ? null : this.slotOmap.pop().value;
	public function shift():Null<V> return this.slotOmap.isEmpty() ? null : this.slotOmap.shift().value;
	public function clear():Void this.slotOmap.clear();

}
