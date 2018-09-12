package arpx.impl.cross.geom;

import picotest.PicoAssert.*;

class TransformCase {

	var me:Transform = new Transform().reset(1.0, 0.0, 0.0, 2.0, 300.0, 400.0);

	private var data(get, never):Array<Float>;
	private function get_data():Array<Float> return me.toData();

	public function setup() {
	}

	public function testReset() {
		me.reset(20.0, 0.0, 1.0, 30.0, 50.0, 100.0);
		assertMatch([20.0, 0.0, 1.0, 30.0, 50.0, 100.0], data);
	}

	public function testReadData() {
		me.readData([20.0, 0.0, 1.0, 30.0, 50.0, 100.0]);
		assertMatch([20.0, 0.0, 1.0, 30.0, 50.0, 100.0], data);
	}

	public function testToData() {
		var data:Array<Float> = me.toData();
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testClone() {
		var other:Transform = me.clone();
		var data:Array<Float> = other.toData();
		assertNotEquals(me, other);
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testCopyFrom() {
		var other:Transform = new Transform();
		var data:Array<Float> = other.copyFrom(me).toData();
		assertMatch([1.0, 0.0, 0.0, 2.0, 300.0, 400.0], data);
	}

	public function testSetXY() {
		me.setXY(256.0, 512.0);
		assertMatch([1.0, 0.0, 0.0, 2.0, 256.0, 512.0], data);
	}

	public function testAppendXY() {
		me.appendXY(256.0, 512.0);
		assertMatch([1.0, 0.0, 0.0, 2.0, 556.0, 912.0], data);
	}

	public function testAppendTransform() {
		me.appendTransform(new Transform().reset(3.0, 0.0, 0.0, 1.0, 10.0, 20.0));
		assertMatch([3.0, 0.0, 0.0, 2.0, 910.0, 420.0], data);
	}
}
