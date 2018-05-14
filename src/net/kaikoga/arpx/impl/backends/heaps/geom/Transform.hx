package net.kaikoga.arpx.impl.backends.heaps.geom;

#if arp_backend_heaps

import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.geom.MatrixImpl;

class Transform implements ITransform {

	public var raw(default, null):MatrixImpl;

	public function new() {
		this.raw = new MatrixImpl();
		this.raw.identity();
	}

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		var v:MatrixImpl = this.raw;
		v._11 = a;
		v._12 = c;
		v._13 = 0;
		v._14 = 0;
		v._21 = b;
		v._22 = d;
		v._23 = 0;
		v._24 = 0;
		v._31 = 0;
		v._32 = 0;
		v._33 = 0;
		v._34 = 0;
		v._41 = tx;
		v._42 = ty;
		v._43 = 0;
		v._44 = 1;
		return this;
	}

	public function clone():Transform {
		return new Transform().copyFrom(this);
	}

	public function copyFrom(source:Transform):Transform {
		this.raw.load(source.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):Transform {
		this.reset(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):Transform {
		this.raw.load(matrix);
		return this;
	}

	public function asPoint():PointImpl {
		if (this.raw._11 == 1 && this.raw._12 == 0 && this.raw._21 == 0 && this.raw._22 == 1) {
			return new PointImpl(this.raw._41, this.raw._42);
		}
		return null;
	}

	public function asMatrix():MatrixImpl {
		return this.raw;
	}

	public function toPoint():PointImpl {
		return new PointImpl(this.raw._41, this.raw._42);
	}

	public function toMatrix():MatrixImpl {
		return this.raw;
	}

	public function setXY(x:Float, y:Float):Transform {
		this.raw._41 = x;
		this.raw._42 = y;
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		this.raw.multiply(transform.toMatrix(), this.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		// this.value.translate(x, y);
		this.raw._41 += x;
		this.raw._42 += y;
		return this;
	}
}

#end
