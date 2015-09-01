package net.kaikoga.arp.domain.mocks;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class MockArpObject implements IArpObject {

	public var intField:Int = 0;

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
		if (seed != null) for (element in seed) {
			intField = Std.parseInt(element.value());
		}
		return this;
	}
}
