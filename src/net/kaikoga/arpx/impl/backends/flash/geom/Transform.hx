package net.kaikoga.arpx.impl.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.geom.MatrixImpl;

class Transform implements ITransform {

	public var raw(default, null):MatrixImpl;

	public function new() raw = new MatrixImpl();

	public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		this.raw.setTo(a, b, c, d, tx, ty);
		return this;
	}

	public function clone():Transform {
		return new Transform().copyFrom(this);
	}

	public function copyFrom(source:Transform):Transform {
		this.raw.copyFrom(source.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):Transform {
		this.raw.setTo(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):Transform {
		this.raw.copyFrom(matrix);
		return this;
	}

	public function asPoint():PointImpl {
		if (this.raw.a == 1 && this.raw.b == 0 && this.raw.c == 0 && this.raw.d == 1) {
			return new PointImpl(this.raw.tx, this.raw.ty);
		}
		return null;
	}

	public function asMatrix():MatrixImpl {
		return this.raw;
	}

	public function toPoint():PointImpl {
		return new PointImpl(this.raw.tx, this.raw.ty);
	}

	public function toMatrix():MatrixImpl {
		return this.raw;
	}

	public function setXY(x:Float, y:Float):Transform {
		this.raw.tx = x;
		this.raw.ty = y;
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		this.raw.concat(transform.toMatrix());
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		this.raw.translate(x, y);
		return this;
	}
}

#end
