package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class ArpDomainCase {

	public function testNewEmptyDomain():Void {
		var domain = new ArpDomain();
	}

	public function testAddArpObject():Void {
		var domain = new ArpDomain();
		var child1 = domain.root.trueChild("test");
		var arpObj1:IArpObject = new MockArpObject();
		child1.addArpObject(arpObj1);

		var child2 = domain.root.trueChild("test");
		var arpObj2:IArpObject = child2.getValue(new ArpType("TestArpObject"));
		assertEquals(arpObj1, arpObj2);
		assertEquals(child1, child2);

		//var slot:ArpSlot<MockArpObject> = ArpTypedSlot.toTypedSlot(child2.getOrCreateSlot(new ArpType("TestArpObject")));
		//var slot:ArpSlot<MockArpObject> = cast child2.getOrCreateSlot(new ArpType("TestArpObject"));
		var slot:ArpSlot<MockArpObject> = child2.getOrCreateSlot(new ArpType("TestArpObject"));
		assertEquals(arpObj1, slot.value);

		assertEquals(1, 2);
	}

	public function testLoadSeed():Void {
		var domain = new ArpDomain();
		var slot:ArpSlot<MockArpObject> = domain.root.getOrCreateSlot(new ArpType("TestArpObject"));
		var arpObj:MockArpObject = new MockArpObject();
		var xml:Xml = Xml.parse('<data name="name1" value="42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		arpObj.init(slot, seed);
		assertEquals(42, arpObj.intField);
	}
}
