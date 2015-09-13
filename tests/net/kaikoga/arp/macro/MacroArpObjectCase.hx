package net.kaikoga.arp.macro;

import net.kaikoga.arp.macro.mocks.MockMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MacroArpObjectCase {

	public function testAddArpObject():Void {
		var domain = new ArpDomain();
		var child1 = domain.root.trueChild("test");
		var arpObj1:IArpObject = new MockMacroArpObject();
		child1.addArpObject(arpObj1);

		var child2 = domain.root.trueChild("test");
		var arpObj2:IArpObject = child2.getValue(new ArpType("MockMacroArpObject"));
		assertEquals(arpObj1, arpObj2);
		assertEquals(child1, child2);

		//var slot:ArpSlot<MockMacroArpObject> = ArpTypedSlot.toTypedSlot(child2.getOrCreateSlot(new ArpType("MockMacroArpObject")));
		//var slot:ArpSlot<MockMacroArpObject> = cast child2.getOrCreateSlot(new ArpType("MockMacroArpObject"));
		var slot:ArpSlot<MockMacroArpObject> = child2.getOrCreateSlot(new ArpType("MockMacroArpObject"));
		assertEquals(arpObj1, slot.value);
	}

	public function testLoadSeed():Void {
		var domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("MockMacroArpObject"), MockMacroArpObject));
		var xml:Xml = Xml.parse('<data name="name1" intField="42" refField="/name1" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		var slot:ArpSlot<MockMacroArpObject> = domain.loadSeed(seed, new ArpType("MockMacroArpObject"));
		var arpObj:MockMacroArpObject = slot.value;

		assertEquals(42, arpObj.intField);
		assertEquals(arpObj, arpObj.refField);
	}

	public function testBuildObject():Void {
		var domain = new ArpDomain();
		var slot:ArpSlot<MockMacroArpObject> = domain.dir("name1").getOrCreateSlot(new ArpType("MockMacroArpObject"));
		var arpObj:MockMacroArpObject = new MockMacroArpObject();
		var xml:Xml = Xml.parse('<data name="name1" intField="42" refField="/name1" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		arpObj.init(slot, seed);

		assertEquals(42, arpObj.intField);
		assertEquals(null, arpObj.refField);

		slot.value = arpObj;
		assertEquals(arpObj, arpObj.refField);
	}
}
