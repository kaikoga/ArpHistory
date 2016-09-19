package net.kaikoga.arp.domain.mocks;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class MockColumnArpObject implements IArpObject {

	public var intField:Int = 0;
	public var floatField:Float = 0;
	public var boolField:Bool = false;
	public var stringField:String = null;

	public var refFieldSlot:ArpSlot<MockColumnArpObject>;
	public var refField(get, set):MockColumnArpObject;
	inline private function get_refField():MockColumnArpObject return refFieldSlot.value;
	inline private function set_refField(value:MockColumnArpObject):MockColumnArpObject { refFieldSlot = value.arpSlot(); return value; }

	public function new() {
	}

	private var _arpDomain:ArpDomain;
	public var arpDomain(get, never):ArpDomain;
	private function get_arpDomain():ArpDomain return this._arpDomain;

	public static var _arpTypeInfo(default, never):ArpTypeInfo = new ArpTypeInfo("column", new ArpType("mock"));
	public function arpTypeInfo():ArpTypeInfo return _arpTypeInfo;
	public var arpType(get, never):ArpType;
	private function get_arpType():ArpType return _arpTypeInfo.arpType;

	private var _arpSlot:ArpSlot<MockColumnArpObject>;
	public function arpSlot():ArpSlot<MockColumnArpObject> return this._arpSlot;

	public function arpInit(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this._arpDomain = slot.domain;
		this._arpSlot = slot;
		this.refFieldSlot = slot.domain.nullSlot;
		if (seed != null) for (element in seed) this.arpConsumeSeedElement(element);
		this.init();
		return this;
	}

	public function init():Void {

	}

	public function arpHeatLater():Void {
		this._arpDomain.heatLater(this.refFieldSlot);
	}

	public function arpHeatUp():Bool {
		return this.heatUp();
	}

	public function heatUp():Bool {
		return true;
	}

	public function arpHeatDown():Bool {
		return this.heatDown();
	}

	public function heatDown():Bool {
		return true;
	}

	public function arpDispose():Void {
		this.dispose();
		this._arpSlot = null;
		this._arpDomain = null;
	}

	public function dispose():Void {

	}

	private function arpConsumeSeedElement(element:ArpSeed):Void {
		switch (element.typeName()) {
			case "if":
				this.intField = Std.parseInt(element.value());
			case "ff":
				this.floatField = Std.parseFloat(element.value());
			case "bf":
				this.boolField = element.value() == "true";
			case "sf":
				this.stringField = element.value();
			case "rf":
				this.refFieldSlot = this._arpDomain.loadSeed(element, new ArpType("mock"));
		}
	}

	public function readSelf(input:IPersistInput):Void {
		this.intField = input.readInt32("if");
		this.floatField = input.readDouble("ff");
		this.boolField = input.readBool("bf");
		this.stringField = input.readUtf("sf");
		this.refFieldSlot = this._arpDomain.getOrCreateSlot(new ArpSid(input.readUtf("rf")));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeInt32("if", this.intField);
		output.writeDouble("ff", this.floatField);
		output.writeBool("bf", this.boolField);
		output.writeUtf("sf", this.stringField);
		output.writeUtf("rf", this.refFieldSlot.sid.toString());
	}

	@:access(net.kaikoga.arp.domain.ArpDomain)
	public function arpClone():IArpObject {
		var clone:MockColumnArpObject = new MockColumnArpObject();
		clone.arpInit(this._arpDomain.allocSlot());
		clone.arpCopyFrom(this);
		return clone;
	}

	public function arpCopyFrom(source:IArpObject):IArpObject {
		var src:MockColumnArpObject = cast source;
		this.intField = src.intField;
		this.floatField = src.floatField;
		this.boolField = src.boolField;
		this.stringField = src.stringField;
		this.refField = src.refField;
		return this;
	}

}
