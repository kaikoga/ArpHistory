package net.kaikoga.arp.macro;

import net.kaikoga.arp.domain.ArpHeat;
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
		assertFalse(domain.isPending);
		assertEquals(0, arpObj.volatileInt);
		assertEquals(ArpHeat.Cold, arpObj.arpSlot().heat);

		domain.heatLater(slot);
		domain.rawTick.dispatch(10.0);
		assertTrue(domain.isPending);
		assertEquals(0, arpObj.volatileInt);
		assertEquals(ArpHeat.Warming, arpObj.arpSlot().heat);

		assertLater(function():Void {
			assertTrue(domain.isPending);
			assertEquals(1, arpObj.volatileInt);
			assertEquals(ArpHeat.Warming, arpObj.arpSlot().heat);

			domain.rawTick.dispatch(10.0);
			assertFalse(domain.isPending);
			assertEquals(1, arpObj.volatileInt);
			assertEquals(ArpHeat.Warm, arpObj.arpSlot().heat);

			domain.heatDown(slot);
			assertFalse(domain.isPending);
			assertEquals(0, arpObj.volatileInt);
			assertEquals(ArpHeat.Cold, arpObj.arpSlot().heat);
		}, 1200);
	}

	@:access(net.kaikoga.arp.macro.mocks.MockLatePrepareMacroArpObject)
	public function testHeatUpDispose():Void {
		assertFalse(domain.isPending);
		assertEquals(0, arpObj.volatileInt);
		assertEquals(ArpHeat.Cold, arpObj.arpSlot().heat);

		domain.heatLater(slot);
		domain.rawTick.dispatch(10.0);
		assertTrue(domain.isPending);
		assertEquals(0, arpObj.volatileInt);
		assertEquals(ArpHeat.Warming, arpObj.arpSlot().heat);

		assertLater(function():Void {
			assertTrue(domain.isPending);
			assertEquals(1, arpObj.volatileInt);
			assertEquals(ArpHeat.Warming, arpObj.arpSlot().heat);

			domain.rawTick.dispatch(10.0);
			assertFalse(domain.isPending);
			assertEquals(1, arpObj.volatileInt);
			assertEquals(ArpHeat.Warm, arpObj.arpSlot().heat);

			arpObj.arpDispose();
			assertFalse(domain.isPending);
			assertEquals(0, arpObj.volatileInt);
			assertNull(arpObj._arpSlot);
			assertNull(arpObj._arpDomain);
		}, 1200);
	}

}
