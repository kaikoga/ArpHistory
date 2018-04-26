package net.kaikoga.arpx.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;

class APoint extends Point implements ITransform {

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

	public function asPoint():APoint {
		return this;
	}

	public function asMatrix():AMatrix {
		return new AMatrix(1, 0, 0, 1, this.x, this.y);
	}

	public function toPoint():APoint {
		return this;
	}

	public function toMatrix():AMatrix {
		return new AMatrix(1, 0, 0, 1, this.x, this.y);
	}

	public function _setXY(x:Float, y:Float):ITransform {
		this.setTo(x, y);
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		if (Std.is(transform, APoint)) {
			this.add(cast transform);
			return this;
		} else {
			return AMatrix.fromPoint(this)._concatTransform(transform);
		}
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.offset(x, y);
		return this;
	}

	public function setXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._setXY(x, y);
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this)._concatTransform(transform);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this)._concatXY(x, y);
	}
}

#end
