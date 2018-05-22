package net.kaikoga.arp.macro;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpSlot;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.macro.mocks.MockHookMacroArpObject;
import net.kaikoga.arp.seed.ArpSeed;
import picotest.PicoAssert.*;

class HookMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockHookMacroArpObject>;
	private var arpObj:MockHookMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addTemplate(MockHookMacroArpObject, true);
		xml = Xml.parse('<mock name="name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;
	}

	public function testInitDispose():Void {
		assertEquals(1, arpObj.volatileInt);
		arpObj.dispose();
		assertEquals(0, arpObj.volatileInt);
	}

}
