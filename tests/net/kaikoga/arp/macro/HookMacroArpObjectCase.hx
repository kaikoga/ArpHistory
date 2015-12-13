package net.kaikoga.arp.macro;

import net.kaikoga.arp.macro.mocks.MockHookMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class HookMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockHookMacroArpObject>;
	private var arpObj:MockHookMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("mock"), MockHookMacroArpObject));
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
