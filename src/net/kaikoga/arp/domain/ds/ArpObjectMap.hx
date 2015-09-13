package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;
import Map.IMap;

@:access(net.kaikoga.arp.domain.ArpDomain)
class ArpObjectMap<V:IArpObject> implements IMap<String, V> implements IPersistable {

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
		this.slots.set(k, v.arpSlot());
	}

	public function exists(k:String):Bool {
		return this.slots.exists(k);
	}

	public function remove(k:String):Bool {
		return this.slots.remove(k);
	}

	public function keys():Iterator<String> {
		return this.slots.keys();
	}

	public function iterator():Iterator<T> {
		return new ArpObjectMapIterator(this.slots);
	}

	public function toString():String {
		return this.slots.toString();
	}

	public function readSelf(input:IPersistInput):Void {
		this.slots = new Map();
		while ((var key:String = input.readName()) != "") {
			this.slots.set(key, this.domain.getOrCreateSlot(input.readName()));
		}
	}
	public function writeSelf(output:IPersistOutput):Void {
		for (key in this.slots.keys()) {
			output.writeUtf(key);
			output.writeUtf(this.slots.get(key).sid.toString());
		}
	}
}

class ArpObjectMapIterator<V:IArpObject> {

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
		return this.slots.get(this.keyIter.next());
	}
}
