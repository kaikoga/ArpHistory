package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MockArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockArpObject>;
	private var arpObj:MockArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addDefaultGenerator(new ArpObjectGenerator(MockArpObject));
		xml = Xml.parse('<mock name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testBuildObject():Void {
		slot = domain.dir("name1").getOrCreateSlot(new ArpType("mock"));
		arpObj = new MockArpObject();
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
		arpObj = domain.allocObject(MockArpObject);

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

	private function roundTrip<T:IArpObject>(inObject:T, klass:Class<T>):T {
		var bytesOutput:BytesOutput = new BytesOutput();
		inObject.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		var outObject:T = domain.allocObject(klass);
		outObject.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		return outObject;
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var arpObj2:MockArpObject = roundTrip(arpObj, MockArpObject);

		assertEquals(arpObj.arpDomain(), arpObj2.arpDomain());
		assertEquals(arpObj.arpType(), arpObj2.arpType());
		assertNotEquals(arpObj.arpSlot(), arpObj2.arpSlot());

		assertEquals(arpObj.intField, arpObj2.intField);
		assertEquals(arpObj.floatField, arpObj2.floatField);
		assertEquals(arpObj.boolField, arpObj2.boolField);
		assertEquals(arpObj.stringField, arpObj2.stringField);
		assertEquals(arpObj.refField, arpObj2.refField);
	}
}
