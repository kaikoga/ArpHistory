package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.ds.impl.ArrayList;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IList;

class ArpObjectList<V:IArpObject> implements IList<V> {

	private var domain:ArpDomain;
	public var slotList(default, null):IList<ArpSlot<V>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.slotList = new ArrayList();
	}

	//read
	public function isEmpty():Bool return this.slotList.isEmpty();
	public function hasValue(v:V):Bool return this.slotList.hasValue(v.arpSlot());
	public function iterator():Iterator<V> return new ArpObjectIterator(this.slotList.iterator());
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, null):Int;
	public function get_length():Int return this.slotList.length;
	public function first():Null<V> return this.slotList.isEmpty() ? null : this.slotList.first().value;
	public function last():Null<V> return this.slotList.isEmpty() ? null : this.slotList.last().value;
	public function getAt(index:Int):Null<V> {
		var slot:ArpSlot<V> = this.slotList.getAt(index);
		return (slot == null) ? null : slot.value;
	}

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.slotList.indexOf(v.arpSlot(), fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.slotList.lastIndexOf(v.arpSlot(), fromIndex);

	//write
	public function push(v:V):Int return this.slotList.push(v.arpSlot());
	public function unshift(v:V):Void this.slotList.unshift(v.arpSlot());
	public function insertAt(index:Int, v:V):Void this.slotList.insertAt(index, v.arpSlot());

	//remove
	public function pop():Null<V> return this.slotList.isEmpty() ? null : this.slotList.pop().value;
	public function shift():Null<V> return this.slotList.isEmpty() ? null : this.slotList.shift().value;
	public function remove(v:V):Bool return this.slotList.remove(v.arpSlot());
	public function removeAt(index:Int):Bool return this.slotList.removeAt(index);
	public function clear():Void this.slotList.clear();
}
