package net.kaikoga.arpx.impl.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.geom.MatrixImpl;
import flash.geom.Matrix;
import flash.geom.Point;
import net.kaikoga.arpx.geom.ITransform;

class AMatrix extends Matrix implements ITransform {

	public function toCopy():ITransform {
		return AMatrix.fromTransform(this);
	}

	public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {
		super(a, b, c, d, tx, ty);
	}

	public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):AMatrix {
		this.setTo(a, b, c, d, tx, ty);
		return this;
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

	public function asPoint():PointImpl {
		if (this.a == 1 && this.b == 0 && this.c == 0 && this.d == 1) {
			return new PointImpl(this.tx, this.ty);
		}
		return null;
	}

	public function asMatrix():MatrixImpl {
		return this;
	}

	public function toPoint():PointImpl {
		return new PointImpl(this.tx, this.ty);
	}

	public function toMatrix():MatrixImpl {
		return this;
	}

	public function setXY(x:Float, y:Float):ITransform {
		this.tx = x;
		this.ty = y;
		return this;
	}

	public function appendTransform(transform:ITransform):ITransform {
		this.concat(transform.toMatrix());
		return this;
	}

	public function appendXY(x:Float, y:Float):ITransform {
		this.translate(x, y);
		return this;
	}
}

#end
