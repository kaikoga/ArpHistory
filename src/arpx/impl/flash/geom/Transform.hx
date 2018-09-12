package arpx.impl.flash.geom;

#if arp_display_backend_flash

import arpx.impl.cross.geom.ITransform;
import arpx.impl.cross.geom.MatrixImpl;
import arpx.impl.cross.geom.PointImpl;

class Transform implements ITransform {

	public var raw(default, null):MatrixImpl;

	public function new() raw = new MatrixImpl();

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		this.raw.setTo(a, b, c, d, tx, ty);
		return this;
	}

	inline public function readData(data:Array<Float>):Transform {
		if (data.length < 6) return this;
		this.raw.setTo(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.raw.a;
		data[1] = this.raw.b;
		data[2] = this.raw.c;
		data[3] = this.raw.d;
		data[4] = this.raw.tx;
		data[5] = this.raw.ty;
		return data;
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

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return new PointImpl(x, y);
		pt.setTo(x, y);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.raw.a == 1 && this.raw.b == 0 && this.raw.c == 0 && this.raw.d == 1) {
			return setOrAllocPointImpl(this.raw.tx, this.raw.ty, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.raw.tx, this.raw.ty, pt);
	}

	public function setXY(x:Float, y:Float):Transform {
		this.raw.tx = x;
		this.raw.ty = y;
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		this.raw.concat(transform.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		this.raw.translate(x, y);
		return this;
	}
}

#end
