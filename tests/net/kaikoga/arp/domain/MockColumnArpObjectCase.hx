package net.kaikoga.arp.domain;

import net.kaikoga.arp.tests.ArpDomainTestUtil;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.domain.mocks.MockColumnArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MockColumnArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockColumnArpObject>;
	private var arpObj:MockColumnArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(MockColumnArpObject, true));
		xml = Xml.parse('<mock name="name1" if="42" ff="3.14" bf="true" sf="stringValue" rf="/name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testBuildObject():Void {
		slot = domain.dir("name1").getOrCreateSlot(new ArpType("mock"));
		arpObj = new MockColumnArpObject();
		arpObj.arpInit(slot, seed);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertEquals(42, arpObj.intField);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertEquals(null, arpObj.refField);

		slot.value = arpObj;
		assertEquals(arpObj, arpObj.refField);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockColumnArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());

		assertEquals(arpObj.intField, 0);
		assertEquals(arpObj.floatField, 0.0);
		assertEquals(arpObj.boolField, false);
		assertEquals(arpObj.stringField, null);
		assertEquals(arpObj.refField, null);
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		assertEquals(42, arpObj.intField);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertEquals(arpObj, arpObj.refField);
	}

	private function checkIsClone(original:MockColumnArpObject, clone:MockColumnArpObject):Void {
		assertEquals(original.arpDomain(), clone.arpDomain());
		assertEquals(original.arpType(), clone.arpType());
		assertNotEquals(original.arpSlot(), clone.arpSlot());

		assertEquals(original.intField, clone.intField);
		assertEquals(original.floatField, clone.floatField);
		assertEquals(original.boolField, clone.boolField);
		assertEquals(original.stringField, clone.stringField);
		assertEquals(original.refField, clone.refField);
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockColumnArpObject = ArpDomainTestUtil.roundTrip(domain, arpObj, MockColumnArpObject);
		checkIsClone(arpObj, clone);
	}

	public function testArpClone():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockColumnArpObject = cast arpObj.arpClone();
		checkIsClone(arpObj, clone);
	}
}
