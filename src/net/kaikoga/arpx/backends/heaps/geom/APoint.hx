package net.kaikoga.arpx.backends.heaps.geom;

#if arp_backend_heaps

import h3d.col.Point;
import net.kaikoga.arpx.geom.ITransform;

class APoint extends Point implements ITransform {

	public function toCopy():ITransform {
		return APoint.fromTransform(this);
	}

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}

	inline public function reset(x:Float, y:Float):APoint {
		this.set(x, y, 0);
		return this;
	}

	public static function fromTransform(transform:ITransform):APoint {
		var result:APoint = new APoint();
		result.load(transform.toPoint());
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

	public function setXY(x:Float, y:Float):ITransform {
		this.set(x, y, 0);
		return this;
	}

	public function appendTransform(transform:ITransform):ITransform {
		if (Std.is(transform, APoint)) {
			this.add(cast transform);
			return this;
		} else {
			return AMatrix.fromPoint(this).appendTransform(transform);
		}
	}

	public function appendXY(x:Float, y:Float):ITransform {
		this.x += x;
		this.y += y;
		return this;
	}

	public function concatTransform(transform:ITransform):ITransform {
		return AMatrix.fromTransform(this).appendTransform(transform);
	}

	public function concatXY(x:Float, y:Float):ITransform {
		return APoint.fromTransform(this).appendXY(x, y);
	}
}

#end
