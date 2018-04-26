package net.kaikoga.arpx.backends.kha.math;

#if arp_backend_kha

import kha.math.Vector2;
import kha.math.Matrix3;

class AMatrix extends Matrix3 implements ITransform {

	public function toCopy():ITransform {
		return AMatrix.fromTransform(this);
	}

	public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {
		super(a, b, tx, c, d, ty, 0, 0, 1);
	}

	public static function fromPoint(pt:Vector2):AMatrix {
		var result:AMatrix = new AMatrix(1, 0, 0, 1, pt.x, pt.y);
		return result;
	}

	public static function fromMatrix(matrix:Matrix3):AMatrix {
		var result:AMatrix = new AMatrix();
		result.setFrom(matrix);
		return result;
	}

	public static function fromTransform(transform:ITransform):AMatrix {
		var result:AMatrix = new AMatrix();
		result.setFrom(transform.toMatrix());
		return result;
	}

	public function asPoint():APoint {
		if (this._00 == 1 && this._10 == 0 && this._01 == 0 && this._11 == 1) {
			return new APoint(this._20, this._21);
		}
		return null;
	}

	public function asMatrix():AMatrix {
		return this;
	}

	public function toPoint():APoint {
		return new APoint(this._20, this._21);
	}

	public function toMatrix():AMatrix {
		return this;
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this._20 = x;
		this._21 = y;
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		return this._concatMatrix(transform.toMatrix());
	}

	public function _concatMatrix(matrix:Matrix3):ITransform {
		this.setFrom(this.multmat(matrix));
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this._20 += x;
		this._21 += y;
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
