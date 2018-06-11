package arp.hit.strategies;

import arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitWithCuboidCase {

	private var me:HitWithCuboid;

	public function setup() {
		me = new HitWithCuboid();
	}

	public function testCollides() {
		var a = new HitGeneric().setCuboid(1, 1, 1, 2, 2, 2);
		var b = new HitGeneric().setCuboid(3, 1, 1, 1, 1, 1);
		var c = new HitGeneric().setCuboid(5, 1, 1, 1, 1, 1);
		assertTrue(me.collides(a, b));
		assertFalse(me.collides(b, c));
		assertFalse(me.collides(a, c));
	}

}
