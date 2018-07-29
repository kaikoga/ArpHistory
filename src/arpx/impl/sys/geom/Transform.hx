package arpx.impl.sys.geom;

#if arp_display_backend_sys

import arpx.impl.cross.geom.ITransform;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.MatrixImpl;

class Transform implements ITransform {

	public var raw(default, null):MatrixImpl;

	public function new() {
		this.raw = new MatrixImpl();
	}

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		return this;
	}

	public function clone():Transform {
		return new Transform();
	}

	public function copyFrom(source:Transform):Transform {
		return this;
	}

	public function readPoint(pt:PointImpl):Transform {
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):Transform {
		return this;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return new PointImpl();
	}

	public function setXY(x:Float, y:Float):Transform {
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		return this;
	}
}

#end
