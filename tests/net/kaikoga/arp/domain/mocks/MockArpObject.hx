package net.kaikoga.arp.domain.mocks;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class MockArpObject implements IArpObject {

	public var intField:Int = 0;
	public var refFieldSlot:ArpSlot<MockArpObject>;
	public var refField(get, set):MockArpObject;
	inline private function get_refField():MockArpObject return refFieldSlot.value;
	inline private function set_refField(value:MockArpObject):MockArpObject { refFieldSlot = value.arpSlot(); return value; }

	public function new() {
	}

	public function arpDomain():ArpDomain {
		return null;
	}

	public function arpType():ArpType {
		return new ArpType("TestArpObject");
	}

	public function arpSlot():ArpSlot<MockArpObject> {
		return null;
	}

	public function init(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this.refFieldSlot = slot.domain.nullSlot;
		if (seed != null) for (element in seed) {
			switch (element.typeName()) {
				case "intField":
					this.intField = Std.parseInt(element.value());
				case "refField":
					this.refFieldSlot = slot.domain.query(element.value(), this.arpType()).slot();
			}
		}
		return this;
	}
}
