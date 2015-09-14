package net.kaikoga.arp.macro;

import net.kaikoga.arp.macro.mocks.MockMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class MacroArpObjectCase {

	public function testBuildObject():Void {
		var domain = new ArpDomain();
		var slot:ArpSlot<MockMacroArpObject> = domain.dir("name1").getOrCreateSlot(new ArpType("MockMacroArpObject"));
		var arpObj:MockMacroArpObject = new MockMacroArpObject();
		var xml:Xml = Xml.parse('<data name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		arpObj.init(slot, seed);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("MockMacroArpObject"), arpObj.arpType());
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
