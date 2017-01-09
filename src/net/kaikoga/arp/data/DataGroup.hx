package net.kaikoga.arp.data;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ArpTypeInfo;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot;

class DataGroup implements IArpObject {

	// ISSUE can we omit creating anonymous DataGroup at all?

	private var name:String;
	private var children:Array<ArpUntypedSlot>;

	public function new(children:Array<ArpUntypedSlot> = null) {
		if (children == null) children = [];
		this.children = children;
	}

	private var _arpDomain:ArpDomain;
	public var arpDomain(get, never):ArpDomain;
	inline private function get_arpDomain():ArpDomain return this._arpDomain;

	public static var _arpTypeInfo(default, never):ArpTypeInfo = new ArpTypeInfo("data", new ArpType("data"));
	public var arpTypeInfo(get, never):ArpTypeInfo;
	private function get_arpTypeInfo():ArpTypeInfo return _arpTypeInfo;

	public var arpType(get, never):ArpType;
	private function get_arpType():ArpType return _arpTypeInfo.arpType;

	private var _arpSlot:ArpSlot<DataGroup>;
	public var arpSlot(get, never):ArpSlot<DataGroup>;
	inline private function get_arpSlot():ArpSlot<DataGroup> return this._arpSlot;

	public function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this._arpDomain = slot.domain;
		this._arpSlot = slot;
		if (seed != null) {
			this.name = seed.name();
			if (this.name != null && this.children == null) this.children = [];
			for (element in seed) this.arpConsumeSeedElement(element);
		}
		return this;
	}

	public function arpHeatLater():Void {
		for (slot in this.children) this.arpDomain.heatLater(slot);
	}

	public function arpHeatUp():Bool {
		return true;
	}

	public function arpHeatDown():Bool {
		return true;
	}

	public function arpDispose():Void {
		for (slot in this.children) slot.delReference();
		this._arpSlot = null;
		this._arpDomain = null;
	}

	private function arpConsumeSeedElement(element:ArpSeed):Void {
		// NOTE seed iterates through value, which we must ignore
		if (element.typeName() != "value") {
			var slot = this.arpDomain.loadSeed(element).addReference();
			if (slot != null && this.name != null) {
				this.children.push(slot);
			}
		}
	}

	public function readSelf(input:IPersistInput):Void {
	}

	public function writeSelf(output:IPersistOutput):Void {
	}

	public function arpClone():IArpObject {
		throw "not supported";
	}

	public function arpCopyFrom(source:IArpObject):IArpObject {
		throw "not supported";
	}

	public function add(slot:ArpUntypedSlot):Void {
		this.children.push(slot);
	}

	public function allocObject<T:IArpObject>(klass:Class<T>, args:Array<Dynamic> = null, sid:ArpSid = null):T {
		var obj:T = this.arpDomain.allocObject(klass, args, sid);
		this.children.push(obj.arpSlot);
		return obj;
	}

	public function addObject<T:IArpObject>(arpObj:T, sid:ArpSid = null):T {
		var obj:T = this.arpDomain.addObject(arpObj, sid);
		this.children.push(obj.arpSlot);
		return obj;
	}
}