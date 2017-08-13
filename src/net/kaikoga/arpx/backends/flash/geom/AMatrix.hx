package net.kaikoga.arpx.backends.flash.geom;

import flash.display.DisplayObject;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Point;

class AMatrix extends Matrix implements ITransform {

	public function toCopy():ITransform {
		return AMatrix.fromTransform(this);
	}

	public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {
		super(a, b, c, d, tx, ty);
	}

	public static function fromPoint(pt:Point):AMatrix {
		var result:AMatrix = new AMatrix(1, 0, 0, 1, pt.x, pt.y);
		return result;
	}

	public static function fromMatrix(matrix:Matrix):AMatrix {
		var result:AMatrix = new AMatrix();
		result.copyFrom(matrix);
		return result;
	}

	public static function fromTransform(transform:ITransform):AMatrix {
		var result:AMatrix = new AMatrix();
		result.copyFrom(transform.toMatrix());
		return result;
	}

	public function asPoint():Point {
		if (this.a == 1 && this.b == 0 && this.c == 0 && this.d == 1) {
			return new Point(this.tx, this.ty);
		}
		return null;
	}

	public function asMatrix():Matrix {
		return this;
	}

	public function asMatrix3D():Matrix3D {
		return null;
	}

	public function toPoint():Point {
		return new Point(this.tx, this.ty);
	}

	public function toMatrix():Matrix {
		return this;
	}

	public function toMatrix3D():Matrix3D {
		return new Matrix3D();
	}

	public function applyTo(target:DisplayObject):Void {
		target.transform.matrix = this.toMatrix();
	}

	public function _setMatrix(matrix:Matrix):ITransform {
		this.copyFrom(matrix);
		return this;
	}

	public function _setPoint(pt:Point):ITransform {
		this.tx = pt.x;
		this.ty = pt.y;
		return this;
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this.tx = x;
		this.ty = y;
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		return this._concatMatrix(transform.toMatrix());
	}

	public function _concatMatrix(matrix:Matrix):ITransform {
		this.concat(matrix);
		return this;
	}

	public function _concatPoint(pt:Point):ITransform {
		this.translate(pt.x, pt.y);
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.translate(x, y);
		return this;
	}

	public function setMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function setPoint(pt:Point):ITransform {
		return AMatrix.fromTransform(this)._setPoint(pt);
	}

	public function setXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function concatPoint(pt:Point):ITransform {
		return AMatrix.fromTransform(this)._concatPoint(pt);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return AMatrix.fromTransform(this)._concatXY(x, y);
	}
}

