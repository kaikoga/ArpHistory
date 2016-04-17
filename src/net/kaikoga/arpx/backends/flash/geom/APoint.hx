package net.kaikoga.arpx.backends.flash.geom;

import flash.display.BlendMode;
import flash.display.DisplayObject;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Point;

class APoint extends Point implements ITransform {

	public var blendMode(get, never):BlendMode;
	private function get_blendMode():BlendMode return null;

	public var colorTransform(get, never):ColorTransform;
	private function get_colorTransform():ColorTransform return null;

	public function toCopy():ITransform {
		return APoint.fromTransform(this);
	}

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}

	public static function fromTransform(transform:ITransform):APoint {
		var result:APoint = new APoint();
		result.copyFrom(transform.toPoint());
		return result;
	}

	public function asPoint():Point {
		return this;
	}

	public function asMatrix():Matrix {
		return new Matrix(1, 0, 0, 1, this.x, this.y);
	}

	public function asMatrix3D():Matrix3D {
		return new Matrix3D();
	}

	public function toPoint():Point {
		return this;
	}

	public function toMatrix():Matrix {
		return new Matrix(1, 0, 0, 1, this.x, this.y);
	}

	public function toMatrix3D():Matrix3D {
		return new Matrix3D();
	}

	public function applyTo(target:DisplayObject):Void {
		target.x = this.x;
		target.y = this.y;
	}

	public function _setColorTransform(colorTransform:ColorTransform):ITransform {
		return ATransform.fromPoint(this)._setColorTransform(colorTransform);
	}

	public function _setMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._setMatrix(matrix);
	}

	public function _setPoint(pt:Point):ITransform {
		this.copyFrom(pt);
		return this;
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this.setTo(x, y);
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		if (Std.is(transform, APoint)) {
			return this._concatPoint(cast transform);
		} else if (Std.is(transform, AMatrix)) {
			return this._concatMatrix(cast transform);
		} else {
			return ATransform.fromPoint(this)._concatTransform(transform);
		}
	}

	public function _concatColorTransform(colorTransform:ColorTransform):ITransform {
		return ATransform.fromPoint(this)._concatColorTransform(colorTransform);
	}

	public function _concatMatrix(matrix:Matrix):ITransform {
		return AMatrix.fromTransform(this)._concatMatrix(matrix);
	}

	public function _concatPoint(pt:Point):ITransform {
		this.add(pt);
		return this;
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.offset(x, y);
		return this;
	}

	public function setColorTransform(colorTransform:ColorTransform):ITransform {
		return ATransform.fromTransform(this)._setColorTransform(colorTransform);
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
		return ATransform.fromTransform(this)._concatTransform(transform);
	}

	public function concatColorTransform(colorTransform:ColorTransform):ITransform {
		return ATransform.fromTransform(this)._concatColorTransform(colorTransform);
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
