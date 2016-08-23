package net.kaikoga.arp.hit.strategies;

import net.kaikoga.arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitWithAABBCase {

	private var me:HitWithAABB;

	public function setup() {
		me = new HitWithAABB();
	}

	public function testCollides() {
		var a = new HitGeneric().setAABB(1, 1, 1, 2, 2, 2);
		var b = new HitGeneric().setAABB(3, 1, 1, 1, 1, 1);
		var c = new HitGeneric().setAABB(5, 1, 1, 1, 1, 1);
		assertTrue(me.collides(a, b));
		assertFalse(me.collides(b, c));
		assertFalse(me.collides(a, c));
	}

}
