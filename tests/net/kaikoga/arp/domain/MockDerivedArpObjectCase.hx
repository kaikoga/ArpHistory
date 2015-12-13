package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.mocks.MockArpObject;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.mocks.MockDerivedArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MockDerivedArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockArpObject>;
	private var arpObj:MockDerivedArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("mock"), MockDerivedArpObject));
		xml = Xml.parse('<mock name="name1" intField="42" intField2="168" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" refField2="/name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testBuildObject():Void {
		slot = domain.dir("name1").getOrCreateSlot(new ArpType("mock"));
		arpObj = new MockDerivedArpObject();
		arpObj.arpInit(slot, seed);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertEquals(42, arpObj.intField);
		assertEquals(168, arpObj.intField2);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertEquals(null, arpObj.refField);
		assertEquals(null, arpObj.refField2);

		slot.value = arpObj;
		assertMatch(arpObj, arpObj.refField);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockDerivedArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());

		assertEquals(arpObj.intField, 0);
		assertEquals(arpObj.intField2, 0);
		assertEquals(arpObj.floatField, 0.0);
		assertEquals(arpObj.boolField, false);
		assertEquals(arpObj.stringField, null);
		assertEquals(arpObj.refField, null);
		assertEquals(arpObj.refField2, null);
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = cast slot.value;

		assertEquals(42, arpObj.intField);
		assertEquals(168, arpObj.intField2);
		assertEquals(3.14, arpObj.floatField);
		assertEquals(true, arpObj.boolField);
		assertEquals("stringValue", arpObj.stringField);
		assertMatch(arpObj, arpObj.refField);
		assertMatch(arpObj, arpObj.refField2);
	}

	private function roundTrip<T:IArpObject>(inObject:T, klass:Class<T>):T {
		var bytesOutput:BytesOutput = new BytesOutput();
		inObject.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		var outObject:T = domain.allocObject(klass);
		outObject.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		return outObject;
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = cast slot.value;

		var arpObj2:MockDerivedArpObject = roundTrip(arpObj, MockDerivedArpObject);

		assertEquals(arpObj.arpDomain(), arpObj2.arpDomain());
		assertEquals(arpObj.arpType(), arpObj2.arpType());
		assertNotEquals(arpObj.arpSlot(), arpObj2.arpSlot());

		assertEquals(arpObj.intField, arpObj2.intField);
		assertEquals(arpObj.intField2, arpObj2.intField2);
		assertEquals(arpObj.floatField, arpObj2.floatField);
		assertEquals(arpObj.boolField, arpObj2.boolField);
		assertEquals(arpObj.stringField, arpObj2.stringField);
		assertMatch(arpObj.refField, arpObj2.refField);
		assertMatch(arpObj.refField2, arpObj2.refField2);
	}
}
