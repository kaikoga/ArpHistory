package net.kaikoga.arpx.backends.heaps.geom;

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
		_11 = a;
		_12 = b;
		_13 = 0;
		_14 = tx;
		_21 = c;
		_22 = d;
		_23 = 0;
		_24 = ty;
		_31 = 0;
		_32 = 0;
		_33 = 0;
		_34 = 0;
		_41 = 0;
		_42 = 0;
		_43 = 0;
		_44 = 1;
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
			return new APoint(this._14, this._24);
		}
		return null;
	}

	public function asMatrix():AMatrix {
		return this;
	}

	public function toPoint():APoint {
		return new APoint(this._14, this._24);
	}

	public function toMatrix():AMatrix {
		return this;
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this._14 = x;
		this._24 = y;
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		this.multiply(this, transform.toMatrix());
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this._14 += x;
		this._24 += y;
		return this;
	}

	public function setXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._concatXY(x, y);
	}
}

#end
