package net.kaikoga.arp.domain.mocks;

import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class MockArpObject implements IArpObject {

	public var intField:Int = 0;
	public var floatField:Float = 0;
	public var boolField:Bool = false;
	public var stringField:String = null;

	public var refFieldSlot:ArpSlot<MockArpObject>;
	public var refField(get, set):MockArpObject;
	inline private function get_refField():MockArpObject return refFieldSlot.value;
	inline private function set_refField(value:MockArpObject):MockArpObject { refFieldSlot = value.arpSlot(); return value; }

	public function new() {
	}

	private var _arpDomain:ArpDomain;
	public function arpDomain():ArpDomain return this._arpDomain;

	public function arpType():ArpType return new ArpType("TestArpObject");

	private var _arpSlot:ArpSlot<MockArpObject>;
	public function arpSlot():ArpSlot<MockArpObject> return this._arpSlot;

	public function init(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this._arpDomain = slot.domain;
		this._arpSlot = slot;
		this.refFieldSlot = slot.domain.nullSlot;
		if (seed != null) for (element in seed) this.consumeSeedElement(element);
		return this;
	}

	public function dispose():Void {
		this._arpSlot = null;
		this._arpDomain = null;
	}

	private function consumeSeedElement(element:ArpSeed):Void {
		switch (element.typeName()) {
			case "intField":
				this.intField = Std.parseInt(element.value());
			case "floatField":
				this.floatField = Std.parseFloat(element.value());
			case "boolField":
				this.boolField = element.value() == "true";
			case "stringField":
				this.stringField = element.value();
			case "refField":
				this.refFieldSlot = this._arpDomain.loadSeed(element, new ArpType("TestArpObject"));
		}
	}

	public function readSelf(input:IPersistInput):Void {
		this.intField = input.readInt32("intField");
		this.floatField = input.readDouble("floatField");
		this.boolField = input.readBool("boolField");
		this.stringField = input.readUtf("stringField");
		this.refFieldSlot = this._arpDomain.getOrCreateSlot(new ArpSid(input.readUtf("refField")));
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeInt32("intField", this.intField);
		output.writeDouble("floatField", this.floatField);
		output.writeBool("boolField", this.boolField);
		output.writeUtf("stringField", this.stringField);
		output.writeUtf("refField", this.refFieldSlot.sid.toString());
	}

}
