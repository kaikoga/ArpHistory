package arp.hit.strategies;

import arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitWithSphereCase {

	private var me:HitWithSphere;

	public function setup() {
		me = new HitWithSphere();
	}

	public function testCollides() {
		var a = new HitSphere().setSphere(2, 1, 1, 1);
		var b = new HitSphere().setSphere(1, 3, 1, 1);
		var c = new HitSphere().setSphere(1, 5, 1, 1);
		assertTrue(me.collides(a, b));
		assertFalse(me.collides(b, c));
		assertFalse(me.collides(a, c));
	}

}
