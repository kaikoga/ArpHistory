package net.kaikoga.arpx.impl.backends.heaps.geom;

#if arp_backend_heaps

import h3d.col.Point;
import h3d.Matrix;
import net.kaikoga.arpx.geom.ITransform;

class AMatrix extends Matrix implements ITransform {

	public function toCopy():ITransform {
		return AMatrix.fromTransform(this);
	}

	public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {
		super();
		this.reset(a, b, c, d, tx, ty);
	}

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):AMatrix {
		_11 = a;
		_12 = c;
		_13 = 0;
		_14 = 0;
		_21 = b;
		_22 = d;
		_23 = 0;
		_24 = 0;
		_31 = 0;
		_32 = 0;
		_33 = 0;
		_34 = 0;
		_41 = tx;
		_42 = ty;
		_43 = 0;
		_44 = 1;
		return this;
	}

	public static function fromPoint(pt:Point):AMatrix {
		var result:AMatrix = new AMatrix(1, 0, 0, 1, pt.x, pt.y);
		return result;
	}

	public static function fromMatrix(matrix:Matrix):AMatrix {
		var result:AMatrix = new AMatrix();
		result.load(matrix);
		return result;
	}

	public static function fromTransform(transform:ITransform):AMatrix {
		var result:AMatrix = new AMatrix();
		result.load(transform.toMatrix());
		return result;
	}

	public function asPoint():APoint {
		if (this._11 == 1 && this._12 == 0 && this._21 == 0 && this._22 == 1) {
			return new APoint(this._41, this._42);
		}
		return null;
	}

	public function asMatrix():AMatrix {
		return this;
	}

	public function toPoint():APoint {
		return new APoint(this._41, this._42);
	}

	public function toMatrix():AMatrix {
		return this;
	}

	public function setXY(x:Float, y:Float):ITransform {
		this._41 = x;
		this._42 = y;
		return this;
	}

	public function appendTransform(transform:ITransform):ITransform {
		this.multiply(transform.toMatrix(), this);
		return this;
	}

	public function appendXY(x:Float, y:Float):ITransform {
		// this.translate(x, y);
		this._41 += x;
		this._42 += y;
		return this;
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this).appendTransform(transform);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this).appendXY(x, y);
	}
}

#end
