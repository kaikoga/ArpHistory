package net.kaikoga.arpx.backends.flash.geom;

import flash.geom.Point;

import picotest.PicoAssert.*;

class APointCase {

	var me:ATransform = new ATransform(1, 2, 3, 4, 5, 6);

	public function setup() {
	}

	public function testToPoint():Void {
		var me:ATransform = new ATransform();
		var pt:Point = me.toPoint();
		assertEquals(5, pt.x);
		assertEquals(6, pt.y);
	}
}
