package net.kaikoga.arp.domain.ds.std;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;
import Map.IMap;

@:access(net.kaikoga.arp.domain.ArpDomain)
class ArpObjectStdMap<V:IArpObject> implements IMap<String, V> implements IPersistable {

	private var domain:ArpDomain;
	private var slots:Map<String, ArpSlot<V>>;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.slots = new Map();
	}

	public function get(k:String):Null<V> {
		var slot:ArpSlot<V> = this.slots.get(k);
		return (slot != null) ? slot.value : null;
	}

	public function set(k:String, v:V):Void {
		v.arpSlot().addReference();
		this.slots.set(k, v.arpSlot());
	}

	public function exists(k:String):Bool {
		return this.slots.exists(k);
	}

	public function remove(k:String):Bool {
		if (this.slots.exists(k)) this.slots.get(k).delReference();
		return this.slots.remove(k);
	}

	public function keys():Iterator<String> {
		return this.slots.keys();
	}

	public function iterator():Iterator<V> {
		return new ArpObjectStdMapIterator(this.slots);
	}

	public function toString():String {
		return this.slots.toString();
	}

	public function readSelf(input:IPersistInput):Void {
		var oldSlots:Map<String, ArpSlot<V>> = this.slots;
		this.slots = new Map();
		var key:String;
		// TODO better format
		while ((key = input.readName()) != "") {
			this.slots.set(key, this.domain.getOrCreateSlot(new ArpSid(input.readName())).addReference());
		}
		for (item in oldSlots) item.delReference();
	}

	public function writeSelf(output:IPersistOutput):Void {
		// TODO better format
		for (key in this.slots.keys()) {
			output.writeName(key);
			output.writeName(this.slots.get(key).sid.toString());
		}
		output.writeName("");
	}
}

class ArpObjectStdMapIterator<V:IArpObject> {

	private var slots:Map<String, ArpSlot<V>>;
	private var keyIter:Iterator<String>;

	public function new(slots:Map<String, ArpSlot<V>>) {
		this.slots = slots;
		this.keyIter = slots.keys();
	}

	public function hasNext():Bool {
		return this.keyIter.hasNext();
	}

	public function next():V {
		return this.slots.get(this.keyIter.next()).value;
	}
}
