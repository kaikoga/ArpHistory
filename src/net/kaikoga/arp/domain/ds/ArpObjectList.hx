package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.ds.impl.ArrayList;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IList;

class ArpObjectList<V:IArpObject> implements IList<V> {

	private var domain:ArpDomain;
	inline private function slotOf(v:V):ArpSlot<V> return ArpSlot.of(v, domain);

	public var slotList(default, null):IList<ArpSlot<V>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.slotList = new ArrayList();
	}

	//read
	public function isEmpty():Bool return this.slotList.isEmpty();
	public function hasValue(v:V):Bool return this.slotList.hasValue(slotOf(v));
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
	public function indexOf(v:V, ?fromIndex:Int):Int return this.slotList.indexOf(slotOf(v), fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.slotList.lastIndexOf(slotOf(v), fromIndex);

	//write
	public function push(v:V):Int return this.slotList.push(slotOf(v).addReference());
	public function unshift(v:V):Void this.slotList.unshift(slotOf(v).addReference());
	public function insertAt(index:Int, v:V):Void this.slotList.insertAt(index, slotOf(v).addReference());

	//remove
	public function pop():Null<V> return this.slotList.isEmpty() ? null : this.slotList.pop().delReference().value;
	public function shift():Null<V> return this.slotList.isEmpty() ? null : this.slotList.shift().delReference().value;
	public function remove(v:V):Bool return this.slotList.remove(slotOf(v).delReference());
	public function removeAt(index:Int):Bool {
		var slot:ArpSlot<V> = this.slotList.getAt(index);
		if (slot == null) return false;
		slot.delReference();
		return this.slotList.removeAt(index);
	}
	public function clear():Void {
		for (slot in this.slotList) slot.delReference();
		this.slotList.clear();
	}
}
