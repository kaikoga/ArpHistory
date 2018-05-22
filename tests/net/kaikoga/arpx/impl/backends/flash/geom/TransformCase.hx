package net.kaikoga.arpx.impl.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;

import picotest.PicoAssert.*;

class TransformCase {

	var me:Transform = new Transform().reset(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);

	public function setup() {
	}

	public function testAsPoint():Void {
		var pt:Point = me.asPoint();
		assertNull(pt);
	}

	public function testToPoint():Void {
		var pt:Point = me.toPoint();
		assertEquals(5.0, pt.x);
		assertEquals(6.0, pt.y);
	}

	public function testRaw():Void {
		var matrix:Matrix = me.raw;
		assertEquals(1.0, matrix.a);
		assertEquals(2.0, matrix.b);
		assertEquals(3.0, matrix.c);
		assertEquals(4.0, matrix.d);
		assertEquals(5.0, matrix.tx);
		assertEquals(6.0, matrix.ty);
	}
}

#end
