package net.kaikoga.arp.domain.ds;

import net.kaikoga.arp.domain.ArpSlot;
import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.ds.access.IMapKnit.IMapKnitPin;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;

@:generic @:remove
class ArpObjectMap<K, V:IArpObject> implements IMap<K, V> implements IPersistable {

	private var domain:ArpDomain;
	inline private function slotOf(v:V):ArpSlot<V> return ArpSlot.of(v, domain);

	public var slotMap(default, null):StdMap<K, ArpSlot<V>>;

	public var heat(get, never):ArpHeat;
	private function get_heat():ArpHeat {
		var result:ArpHeat = ArpHeat.Max;
		for (slot in this.slotMap) {
			var h = slot.heat;
			if (result > h) result = h;
		}
		return result;
	}

	public var isUniqueKey(get, never):Bool;
	public function get_isUniqueKey():Bool return true;
	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return false;

	public function new(domain:ArpDomain) {
		this.domain = domain;
		this.slotMap = new StdMap<K, ArpSlot<V>>();
	}

	//read
	public function isEmpty():Bool return this.slotMap.isEmpty();
	public function hasValue(v:V):Bool return this.slotMap.hasValue(slotOf(v));
	inline public function iterator():Iterator<V> return new ArpObjectIterator(this.slotMap.iterator());
	public function toString():String return CollectionTools.mapToStringImpl(this);
	public function get(k:K):Null<V> return this.slotMap.hasKey(k) ? this.slotMap.get(k).value : null;
	public function hasKey(k:K):Bool return this.slotMap.hasKey(k);
	inline public function keys():Iterator<K> return this.slotMap.keys();

	//resolve
	public function resolveName(v:V):Null<K> return this.slotMap.resolveName(slotOf(v));

	//write
	public function set(k:K, v:V):Void {
		this.slotMap.set(k, slotOf(v).addReference());
	}

	//remove
	public function remove(v:V):Bool return this.slotMap.remove(slotOf(v).delReference());
	public function removeKey(k:K):Bool {
		if (!this.slotMap.hasKey(k)) return false;
		this.slotMap.get(k).delReference();
		return this.slotMap.removeKey(k);
	}
	public function clear():Void {
		for (slot in this.slotMap) slot.delReference();
		this.slotMap.clear();
	}

	// persist
	public function readSelf(input:IPersistInput):Void {
		var oldSlotMap:IMap<K, ArpSlot<V>> = this.slotMap;
		this.slotMap = new StdMap<K, ArpSlot<V>>();
		var nameList:Array<String> = input.readNameList("keys");
		var values:IPersistInput = input.readEnter("values");
		for (name in nameList) {
			this.slotMap.set(cast name, this.domain.getOrCreateSlot(new ArpSid(values.readUtf(name))).addReference());
		}
		values.readExit();

		for (item in oldSlotMap) item.delReference();
	}

	public function writeSelf(output:IPersistOutput):Void {
		var nameList:Array<String> = [for (key in this.slotMap.keys()) cast key];
		output.writeNameList("keys", nameList);
		var values:IPersistOutput = output.writeEnter("values");
		for (name in nameList) {
			values.writeUtf(name, this.slotMap.get(cast name).sid.toString());
		}
		values.writeExit();
	}

	// knit
	public function knit():Iterator<IMapKnitPin<K, V>> return CollectionTools.mapKnitImpl(this);
}
