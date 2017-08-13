package net.kaikoga.arpx.backends.flash.geom;

import flash.geom.Matrix;
import flash.geom.Point;

import picotest.PicoAssert.*;

class APointCase {

	var me:APoint = new APoint(5, 6);

	public function setup() {
	}

	public function testAsPoint():Void {
		var pt:Point = me.asPoint();
		assertEquals(5.0, pt.x);
		assertEquals(6.0, pt.y);
	}

	public function testToPoint():Void {
		var pt:Point = me.toPoint();
		assertEquals(5.0, pt.x);
		assertEquals(6.0, pt.y);
	}

	public function testAsMatrix():Void {
		var matrix:Matrix = me.asMatrix();
		assertEquals(1.0, matrix.a);
		assertEquals(0.0, matrix.b);
		assertEquals(0.0, matrix.c);
		assertEquals(1.0, matrix.d);
		assertEquals(5.0, matrix.tx);
		assertEquals(6.0, matrix.ty);
	}

	public function testToMatrix():Void {
		var matrix:Matrix = me.toMatrix();
		assertEquals(1.0, matrix.a);
		assertEquals(0.0, matrix.b);
		assertEquals(0.0, matrix.c);
		assertEquals(1.0, matrix.d);
		assertEquals(5.0, matrix.tx);
		assertEquals(6.0, matrix.ty);
	}
}
