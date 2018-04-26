package net.kaikoga.arpx.backends.kha.math;

#if arp_backend_kha

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
		result.setFrom(transform.toPoint());
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
		this.x = x;
		this.y = y;
		return this;
	}

	public function _concatTransform(transform:ITransform):ITransform {
		if (Std.is(transform, APoint)) {
			var pt:APoint = cast(transform, APoint);
			this.x += pt.x;
			this.y += pt.y;
			return this;
		} else {
			return AMatrix.fromPoint(this)._concatTransform(transform);
		}
	}

	public function _concatXY(x:Float, y:Float):ITransform {
		this.x += x;
		this.y += y;
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
