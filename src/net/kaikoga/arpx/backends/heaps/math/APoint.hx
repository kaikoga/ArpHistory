package net.kaikoga.arpx.backends.heaps.math;

#if arp_backend_heaps

import h3d.col.Point;
import h3d.Matrix;

class APoint extends Point implements ITransform {

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

	public function asPoint():Point {
		return this;
	}

	public function asMatrix():Matrix {
		return new AMatrix(1, 0, this.x, 0, 1, this.y);
	}

	public function toPoint():Point {
		return this;
	}

	public function toMatrix():Matrix {
		return new AMatrix(1, 0, this.x, 0, 1, this.y);
	}

	public function _setMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function _setPoint(pt:Point):ITransform {
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

	public function _concatMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function _concatPoint(pt:Point):ITransform {
		this.x += pt.x;
		this.y += pt.y;
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.x += x;
		this.y += y;
		return this;
	}

	public function setMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function setPoint(pt:Point):ITransform {
		return APoint.fromTransform(this)._setPoint(pt);
	}

	public function setXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function concatPoint(pt:Point):ITransform {
		return APoint.fromTransform(this)._concatPoint(pt);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._concatXY(x, y);
	}
}

#end
