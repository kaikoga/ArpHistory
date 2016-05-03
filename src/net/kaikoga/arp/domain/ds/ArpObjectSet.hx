package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;

class ArpObjectSet<V:IArpObject> implements ISet<V> {

	private var slotSet:ISet<ArpSlot<V>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new() this.slotSet = new ArraySet();

	// read
	public function isEmpty():Bool return this.slotSet.isEmpty();
	public function hasValue(v:V):Bool return this.slotSet.hasValue(v.arpSlot());
	public function iterator():Iterator<V> return new ArpObjectIterator(this.slotSet.iterator());
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:V):Void return this.slotSet.add(v.arpSlot());

	// remove
	public function remove(v:V):Bool return this.slotSet.remove(v.arpSlot());
	public function clear():Void this.slotSet.clear();
}
