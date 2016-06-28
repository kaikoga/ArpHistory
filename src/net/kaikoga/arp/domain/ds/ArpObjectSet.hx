package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;

class ArpObjectSet<V:IArpObject> implements ISet<V> implements IPersistable {

	private var domain:ArpDomain;
	inline private function slotOf(v:V):ArpSlot<V> return ArpSlot.of(v, this.domain);

	public var slotSet(default, null):ISet<ArpSlot<V>>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.slotSet = new ArraySet();
	}

	// read
	public function isEmpty():Bool return this.slotSet.isEmpty();
	public function hasValue(v:V):Bool return this.slotSet.hasValue(slotOf(v));
	public function iterator():Iterator<V> return new ArpObjectIterator(this.slotSet.iterator());
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:V):Void this.slotSet.add(slotOf(v).addReference());

	// remove
	public function remove(v:V):Bool return this.slotSet.remove(slotOf(v).delReference());
	public function clear():Void {
		for (slot in this.slotSet) slot.delReference();
		this.slotSet.clear();
	}

	// persist
	public function readSelf(input:IPersistInput):Void {
		var oldSlotSet:ISet<ArpSlot<V>> = this.slotSet;
		this.slotSet = new ArraySet();
		var values:Array<String> = input.readNameList("values");
		for (value in values) {
			this.slotSet.add(this.domain.getOrCreateSlot(new ArpSid(value)).addReference());
		}

		for (item in oldSlotSet) item.delReference();
	}

	public function writeSelf(output:IPersistOutput):Void {
		var values:Array<String> = [for (slot in this.slotSet) slot.sid.toString()];
		output.writeNameList("values", values);
	}
}