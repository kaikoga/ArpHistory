﻿package net.kaikoga.arpx.driver;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arpx.mortal.Mortal;

import picotest.PicoAssert.*;

class LinearDriverCase {

	private var domain:ArpDomain;
	private var mortal:Mortal;
	private var me:LinearDriver;

	public function setup() {
		var xml:Xml = Xml.parse('<mortal name="mortal"><driver name="driver" class="linear" /></mortal>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(LinearDriver);
		domain.addTemplate(Mortal, true);
		domain.loadSeed(seed);
		mortal = domain.query("mortal", Mortal).value();
		me = domain.query("mortal/driver", LinearDriver).value();
	}


	public function testToward():Void {
		var pos = mortal.position;
		pos.relocate(1, 2, 3);
		pos.dir = ArpDirection.RIGHT;
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, me.target.x);
		assertMatch(0, me.target.y);
		assertMatch(0, me.target.z);
		assertMatch(0, me.period);
		assertMatch(0, pos.dir.value);
		me.toward(2, 2, 4, 6);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(2, me.target.x);
		assertMatch(4, me.target.y);
		assertMatch(6, me.target.z);
		assertMatch(2, me.period);
		//assertTrue(0 != pos.dir.value);
		me.toward(3, 1, 2, 3, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(3, me.target.x);
		assertMatch(6, me.target.y);
		assertMatch(9, me.target.z);
		assertMatch(3, me.period);
		//assertTrue(0 != pos.dir.value);
		me.towardD(1, 1, 1, 1);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(1, me.target.x);
		assertMatch(1, me.target.y);
		assertMatch(1, me.target.z);
		assertMatch(1, me.period);
		//assertTrue(0 != pos.dir.value);
		me.towardD(3, 1, 0, 1, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(3, me.target.x);
		assertMatch(0, me.target.y);
		assertMatch(3, me.target.z);
		assertMatch(3, me.period);
		//assertMatch(0, pos.dir.value);
	}

	public function testTick():Void {
		var pos = mortal.position;
		pos.relocate(0, 0, 0);
		pos.dir = ArpDirection.RIGHT;
		me.toward(4, 4, 4, 4);
		assertMatch(0, pos.x);
		me.tick(null, mortal);
		assertMatch(1, pos.x);
		me.tick(null, mortal);
		assertMatch(2, pos.x);
		me.tick(null, mortal);
		assertMatch(3, pos.x);
		me.tick(null, mortal);
		assertMatch(4, pos.x);
		me.tick(null, mortal);
		assertMatch(4, pos.x);
	}
}