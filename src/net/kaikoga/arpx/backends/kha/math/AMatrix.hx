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
		result._setMatrix(matrix);
		return result;
	}

	public static function fromTransform(transform:ITransform):AMatrix {
		var result:AMatrix = new AMatrix();
		result._setMatrix(transform.toMatrix());
		return result;
	}

	public function asPoint():Vector2 {
		if (this._00 == 1 && this._10 == 0 && this._01 == 0 && this._11 == 1) {
			return new Vector2(this._20, this._21);
		}
		return null;
	}

	public function asMatrix():Matrix3 {
		return this;
	}

	public function toPoint():Vector2 {
		return new Vector2(this._20, this._21);
	}

	public function toMatrix():Matrix3 {
		return this;
	}

	public function _setMatrix(matrix:Matrix3):ITransform {
		this._00 = matrix._00;
		this._10 = matrix._10;
		this._20 = matrix._20;
		this._01 = matrix._01;
		this._11 = matrix._11;
		this._21 = matrix._21;
		this._02 = matrix._02;
		this._12 = matrix._12;
		this._22 = matrix._22;
		return this;
	}

	public function _setPoint(pt:Vector2):ITransform {
		this._20 = pt.x;
		this._21 = pt.y;
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
		return this._setMatrix(this.multmat(matrix));
	}

	public function _concatPoint(pt:Vector2):ITransform {
		this._20 += pt.x;
		this._21 += pt.y;
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this._20 += x;
		this._21 += y;
		return this;
	}

	public function setMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function setPoint(pt:Vector2):ITransform {
		return AMatrix.fromTransform(this)._setPoint(pt);
	}

	public function setXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function concatPoint(pt:Vector2):ITransform {
		return AMatrix.fromTransform(this)._concatPoint(pt);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._concatXY(x, y);
	}
}

#end
