package net.kaikoga.arp.macro;

import net.kaikoga.arp.tests.ArpDomainTestUtil;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.macro.mocks.MockMacroArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockMacroArpObject>;
	private var arpObj:MockMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(MockMacroArpObject, true));
		xml = Xml.parse('<mock name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" intField3="78" floatField3="1.41" boolField3="false" stringField3="stringValue3" refField="/name1" refField3="/name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockMacroArpObject);

		assertEquals(domain, arpObj.arpDomain);
		assertEquals(new ArpType("mock"), arpObj.arpType);

		assertEquals(1000000, arpObj.intField);
		assertEquals(1000000.0, arpObj.floatField);
		assertEquals(false, arpObj.boolField);
		assertEquals(null, arpObj.stringField);

		assertEquals(5678, arpObj.intField3);
		assertEquals(6789.0, arpObj.floatField3);
		assertEquals(true, arpObj.boolField3);
		assertEquals("stringDefault3", arpObj.stringField3);

		assertEquals(null, arpObj.refField);
		assertEquals(null, arpObj.refField3);

		var refField3Default = domain.loadSeed(seed, new ArpType("mock")).value;
		assertEquals(refField3Default, arpObj.refField3);
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain);
		assertEquals(new ArpType("mock"), arpObj.arpType);
		assertEquals(slot, arpObj.arpSlot);

		assertEquals(42, arpObj.intField);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);

		assertEquals(78, arpObj.intField3);
		assertEquals(1.41, arpObj.floatField3);
		assertEquals(false, arpObj.boolField3);
		assertEquals("stringValue3", arpObj.stringField3);

		assertEquals(arpObj, arpObj.refField);
		assertEquals(arpObj, arpObj.refField3);
	}

	private function checkIsClone(original:MockMacroArpObject, clone:MockMacroArpObject):Void {
		assertEquals(original.arpDomain, clone.arpDomain);
		assertEquals(original.arpType, clone.arpType);
		assertNotEquals(original.arpSlot, clone.arpSlot);

		assertEquals(original.intField, clone.intField);
		assertEquals(original.floatField, clone.floatField);
		assertEquals(original.boolField, clone.boolField);
		assertEquals(original.stringField, clone.stringField);

		assertEquals(original.intField3, clone.intField3);
		assertEquals(original.floatField3, clone.floatField3);
		assertEquals(original.boolField3, clone.boolField3);
		assertEquals(original.stringField3, clone.stringField3);

		assertEquals(original.refField, clone.refField);
		assertEquals(original.refField3, clone.refField3);
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockMacroArpObject = ArpDomainTestUtil.roundTrip(domain, arpObj, MockMacroArpObject);
		checkIsClone(arpObj, clone);
	}

	public function testArpClone():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockMacroArpObject = cast arpObj.arpClone();
		checkIsClone(arpObj, clone);
	}
}
