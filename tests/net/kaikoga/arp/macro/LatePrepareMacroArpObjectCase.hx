package net.kaikoga.arp.macro;

import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.macro.mocks.MockLatePrepareMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;
import picotest.PicoTestAsync.*;

class LatePrepareMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockLatePrepareMacroArpObject>;
	private var arpObj:MockLatePrepareMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(MockLatePrepareMacroArpObject, true));
		xml = Xml.parse('<mock name="name1" />').firstElement();
		seed = ArpSeed.fromXml(xml);
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;
	}

	public function testHeatUpHeatDown():Void {
		assertEquals(0, arpObj.volatileInt);
		domain.heatLater(slot);
		domain.rawTick.dispatch(10.0);
		assertEquals(0, arpObj.volatileInt);
		assertLater(function():Void {
			domain.rawTick.dispatch(10.0);
			assertEquals(1, arpObj.volatileInt);
			arpObj.arpHeatDown();
			assertEquals(0, arpObj.volatileInt);
		}, 1200);
	}

	public function testHeatUpDispose():Void {
		assertEquals(0, arpObj.volatileInt);
		domain.heatLater(slot);
		domain.rawTick.dispatch(10.0);
		assertEquals(0, arpObj.volatileInt);
		assertLater(function():Void {
			domain.rawTick.dispatch(10.0);
			assertEquals(1, arpObj.volatileInt);
			arpObj.arpDispose();
			assertEquals(0, arpObj.volatileInt);
		}, 1200);
	}

}
