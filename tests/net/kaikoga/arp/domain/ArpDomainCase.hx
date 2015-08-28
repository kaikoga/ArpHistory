package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class ArpDomainCase {

	public function testNewEmptyDomain():Void {
		var domain = new ArpDomain();

		var child1 = domain.root.getOrCreateChild("test");
		var arpObj1:IArpObject = new TestArpObject();
		child1.addArpObject(arpObj1);

		var child2 = domain.root.getOrCreateChild("test");
		var arpObj2:IArpObject = child2.getArpObject(new ArpType("TestArpObject"));
		assertEquals(arpObj1, arpObj2);
		assertEquals(child1, child2);

		//var slot:ArpSlot<TestArpObject> = ArpTypedSlot.toTypedSlot(child2.getOrCreateSlot(new ArpType("TestArpObject")));
		//var slot:ArpSlot<TestArpObject> = cast child2.getOrCreateSlot(new ArpType("TestArpObject"));
		var slot:ArpSlot<TestArpObject> = child2.getOrCreateSlot(new ArpType("TestArpObject"));
		assertEquals(arpObj1, slot.arpObject);

		assertEquals(1, 2);
	}

	public function testLoadSeed():Void {
		var domain = new ArpDomain();
		var slot:ArpSlot<TestArpObject> = domain.root.getOrCreateSlot(new ArpType("TestArpObject"));
		var arpObj:TestArpObject = new TestArpObject();
		var xml:Xml = Xml.parse('<data name="" value="42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		arpObj.init(slot, seed);
		assertEquals(42, arpObj.intField);
	}
}

class TestArpObject implements IArpObject {

	public var intField:Int = 0;

	public function new() {
	}

	public function arpDomain():ArpDomain {
		return null;
	}

	public function arpType():ArpType {
		return new ArpType("TestArpObject");
	}

	public function arpSlot():ArpSlot<TestArpObject> {
		return null;
	}
	
	public function init(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		if (seed != null) for (element in seed) {
			intField = Std.parseInt(element.value());
		}
		return this;
	}
}
