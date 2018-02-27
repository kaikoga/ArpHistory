package net.kaikoga.arpx.backends.kha.math;

#if arp_backend_kha

import kha.math.Matrix3;
import kha.math.Vector2;

class APoint extends Vector2 implements ITransform {

	public function toCopy():ITransform {
		return APoint.fromTransform(this);
	}

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}

	public static function fromTransform(transform:ITransform):APoint {
		var result:APoint = new APoint(); 
		result._setPoint(transform.toPoint());
		return result;
	}

	public function asPoint():Vector2 {
		return this;
	}

	public function asMatrix():Matrix3 {
		return new Matrix3(1, 0, this.x, 0, 1, this.y, 0, 0, 1);
	}

	public function toPoint():Vector2 {
		return this;
	}

	public function toMatrix():Matrix3 {
		return new Matrix3(1, 0, this.x, 0, 1, this.y, 0, 0, 1);
	}

	public function _setMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function _setPoint(pt:Vector2):ITransform {
		this.x = pt.x;
		this.y = pt.y;
		return this;
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this.x = x;
		this.y = y;
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		if (Std.is(transform, APoint)) {
			return this._concatPoint(cast transform);
		} else {
			return AMatrix.fromPoint(this)._concatTransform(transform);
		}
	}

	public function _concatMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function _concatPoint(pt:Vector2):ITransform {
		this.x += pt.x;
		this.y += pt.y;
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.x += x;
		this.y += y;
		return this;
	}

	public function setMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function setPoint(pt:Vector2):ITransform {
		return APoint.fromTransform(this)._setPoint(pt);
	}

	public function setXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatMatrix(matrix:Matrix3):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function concatPoint(pt:Vector2):ITransform {
		return APoint.fromTransform(this)._concatPoint(pt);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._concatXY(x, y);
	}
}

#end
