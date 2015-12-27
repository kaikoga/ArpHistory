package net.kaikoga.arp.domain.mocks;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class MockDerivedArpObject extends MockArpObject {

	public var intField2:Int = 0;

	public var refField2Slot:ArpSlot<MockArpObject>;
	public var refField2(get, set):MockArpObject;
	inline private function get_refField2():MockArpObject return refField2Slot.value;
	inline private function set_refField2(value:MockArpObject):MockArpObject { refField2Slot = value.arpSlot(); return value; }

	public function new() {
		super();
	}

	public static var _arpTypeInfo(default, never):ArpTypeInfo = new ArpTypeInfo("derived", new ArpType("mock"));
	override public function arpTypeInfo():ArpTypeInfo return _arpTypeInfo;
	override public function arpType():ArpType return _arpTypeInfo.arpType;

	override public function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this.refField2Slot = slot.domain.nullSlot;
		return super.arpInit(slot, seed);
	}

	override public function arpHeatLater():Void {
		super.arpHeatLater();
		this._arpDomain.heatLater(this.refField2Slot);
	}

	override public function arpDispose():Void {
		super.dispose();
	}

	override private function arpConsumeSeedElement(element:ArpSeed):Void {
		switch (element.typeName()) {
			case "intField2":
				this.intField2 = Std.parseInt(element.value());
			case "refField2":
				this.refField2Slot = this._arpDomain.loadSeed(element, new ArpType("mock"));
			default:
				super.arpConsumeSeedElement(element);
		}
	}

	override public function readSelf(input:IPersistInput):Void {
		super.readSelf(input);
		this.intField2 = input.readInt32("intField2");
		this.refField2Slot = this._arpDomain.getOrCreateSlot(new ArpSid(input.readUtf("refField")));
	}

	override public function writeSelf(output:IPersistOutput):Void {
		super.writeSelf(output);
		output.writeInt32("intField2", this.intField2);
		output.writeUtf("refField2", this.refField2Slot.sid.toString());
	}

	@:access(net.kaikoga.arp.domain.ArpDomain)
	override public function arpClone():IArpObject {
		var clone:MockDerivedArpObject = new MockDerivedArpObject();
		clone.arpInit(this._arpDomain.allocSlot());
		clone.arpCopyFrom(this);
		return clone;
	}

	override public function arpCopyFrom(source:IArpObject):IArpObject {
		var src:MockDerivedArpObject = cast source;
		this.intField2 = src.intField2;
		this.refField2 = src.refField2;
		return super.arpCopyFrom(source);
	}

}
