package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class ArpDirectoryCase {

	public function testAddArpObject():Void {
		var domain = new ArpDomain();
		var child1 = domain.root.trueChild("test");
		var arpObj1:IArpObject = new MockArpObject();
		child1.addOrphanObject(arpObj1);

		var child2 = domain.root.trueChild("test");
		var arpObj2:IArpObject = child2.getValue(new ArpType("mock"));
		assertEquals(arpObj1, arpObj2);
		assertEquals(child1, child2);

		var slot:ArpSlot<MockArpObject> = child2.getOrCreateSlot(new ArpType("mock"));
		assertEquals(arpObj1, slot.value);
	}

}
