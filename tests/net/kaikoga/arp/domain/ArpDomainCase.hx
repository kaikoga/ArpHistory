package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class ArpDomainCase {

	public function testNewEmptyDomain():Void {
		var domain = new ArpDomain();
	}

	public function testLoadSeed():Void {
		var domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("TestArpObject"), MockArpObject));
		var xml:Xml = Xml.parse('<data name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var slot:ArpSlot<MockArpObject> = domain.loadSeed(seed, new ArpType("TestArpObject"));
		var arpObj:MockArpObject = slot.value;

		assertEquals(42, arpObj.intField);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertEquals(arpObj, arpObj.refField);
	}

	public function testBuildObject():Void {
		var domain = new ArpDomain();
		var slot:ArpSlot<MockArpObject> = domain.dir("name1").getOrCreateSlot(new ArpType("TestArpObject"));
		var arpObj:MockArpObject = new MockArpObject();
		var xml:Xml = Xml.parse('<data name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		arpObj.init(slot, seed);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("TestArpObject"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertEquals(42, arpObj.intField);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertEquals(null, arpObj.refField);

		slot.value = arpObj;
		assertEquals(arpObj, arpObj.refField);
	}
}
