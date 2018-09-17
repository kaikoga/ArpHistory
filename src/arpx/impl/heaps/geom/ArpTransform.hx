package arpx.impl.heaps.geom;

#if arp_display_backend_heaps

import h3d.Matrix;
import arp.domain.IArpStruct;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;
import arpx.impl.cross.geom.macro.ArpTransformMacros;
import arpx.impl.cross.geom.IArpTransform;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.MatrixImpl;

@:arpStruct("Transform")
class ArpTransform implements IArpTransform implements IArpStruct {

	public var impl(default, null):MatrixImpl;

	// XXX
	// public var raw(get, never):Matrix;
	// inline private function get_raw():Matrix return impl.raw;

	public function new() {
		this.impl = new MatrixImpl(new Matrix());
		this.impl.identity();
	}

	public function initWithSeed(seed:ArpSeed):ArpTransform ArpTransformMacros.initWithSeed(seed);

	public function initWithString(definition:String, getUnit:String->Float):ArpTransform ArpTransformMacros.initWithString(definition, getUnit);

	public function readSelf(input:IPersistInput):Void ArpTransformMacros.readSelf(input);

	public function writeSelf(output:IPersistOutput):Void ArpTransformMacros.writeSelf(output);

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):ArpTransform {
		this.impl.reset2d(a, b, c, d, tx, ty);
		return this;
	}

	inline public function readData(data:Array<Float>):ArpTransform {
		if (data.length < 6) return this;
		this.reset(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.impl.xx;
		data[1] = this.impl.yx;
		data[2] = this.impl.xy;
		data[3] = this.impl.yy;
		data[4] = this.impl.tx;
		data[5] = this.impl.ty;
		return data;
	}

	public function clone():ArpTransform {
		return new ArpTransform().copyFrom(this);
	}

	public function copyFrom(source:ArpTransform):ArpTransform {
		this.impl.load(source.impl.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):ArpTransform {
		this.reset(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):ArpTransform {
		this.impl.load(matrix.raw);
		return this;
	}

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return PointImpl.alloc(x, y);
		pt.reset(x, y, 0.);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.impl.xx == 1 && this.impl.yx == 0 && this.impl.xy == 0 && this.impl.yy == 1) {
			return setOrAllocPointImpl(this.impl.tx, this.impl.ty, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.impl.tx, this.impl.ty, pt);
	}

	public function setXY(x:Float, y:Float):ArpTransform {
		this.impl.tx = x;
		this.impl.ty = y;
		return this;
	}

	public function prependTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(transform.impl.raw, this.impl.raw);
		return this;
	}

	public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl.tx += x * this.impl.xx + y * this.impl.yx;
		this.impl.ty += x * this.impl.xy + y * this.impl.yy;
		return this;
	}

	public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(this.impl.raw, transform.impl.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl.tx += x;
		this.impl.ty += y;
		return this;
	}
}

#end
