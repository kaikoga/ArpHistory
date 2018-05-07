package net.kaikoga.arpx.impl.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;

import picotest.PicoAssert.*;

class AMatrixCase {

	var me:AMatrix = new AMatrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);

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

	public function testAsMatrix():Void {
		var matrix:Matrix = me.asMatrix();
		assertEquals(1.0, matrix.a);
		assertEquals(2.0, matrix.b);
		assertEquals(3.0, matrix.c);
		assertEquals(4.0, matrix.d);
		assertEquals(5.0, matrix.tx);
		assertEquals(6.0, matrix.ty);
	}

	public function testToMatrix():Void {
		var matrix:Matrix = me.toMatrix();
		assertEquals(1.0, matrix.a);
		assertEquals(2.0, matrix.b);
		assertEquals(3.0, matrix.c);
		assertEquals(4.0, matrix.d);
		assertEquals(5.0, matrix.tx);
		assertEquals(6.0, matrix.ty);
	}
}

#end
