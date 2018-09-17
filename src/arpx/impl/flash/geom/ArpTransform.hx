package arpx.impl.flash.geom;

#if arp_display_backend_flash

import flash.geom.Matrix;
import arp.domain.IArpStruct;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;
import arpx.impl.cross.geom.macro.ArpTransformMacros;
import arpx.impl.cross.geom.IArpTransform;
import arpx.impl.cross.geom.MatrixImpl;
import arpx.impl.cross.geom.PointImpl;

@:arpStruct("Transform")
class ArpTransform implements IArpTransform implements IArpStruct {

	public var impl(default, null):MatrixImpl;

	public var raw(get, never):Matrix;
	inline private function get_raw():Matrix return impl.raw;

	public function new() impl = new MatrixImpl(new Matrix());

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):ArpTransform {
		this.raw.setTo(a, b, c, d, tx, ty);
		return this;
	}

	public function initWithSeed(seed:ArpSeed):ArpTransform ArpTransformMacros.initWithSeed(seed);

	public function initWithString(definition:String, getUnit:String->Float):ArpTransform ArpTransformMacros.initWithString(definition, getUnit);

	public function readSelf(input:IPersistInput):Void ArpTransformMacros.readSelf(input);

	public function writeSelf(output:IPersistOutput):Void ArpTransformMacros.writeSelf(output);

	inline public function readData(data:Array<Float>):ArpTransform {
		if (data.length < 6) return this;
		this.raw.setTo(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.raw.a;
		data[1] = this.raw.b;
		data[2] = this.raw.c;
		data[3] = this.raw.d;
		data[4] = this.raw.tx;
		data[5] = this.raw.ty;
		return data;
	}

	public function clone():ArpTransform {
		return new ArpTransform().copyFrom(this);
	}

	public function copyFrom(source:ArpTransform):ArpTransform {
		this.raw.copyFrom(source.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):ArpTransform {
		this.raw.setTo(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):ArpTransform {
		this.raw.copyFrom(matrix.raw);
		return this;
	}

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return PointImpl.alloc(x, y);
		pt.raw.setTo(x, y);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.raw.a == 1 && this.raw.b == 0 && this.raw.c == 0 && this.raw.d == 1) {
			return setOrAllocPointImpl(this.raw.tx, this.raw.ty, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.raw.tx, this.raw.ty, pt);
	}

	public function setXY(x:Float, y:Float):ArpTransform {
		this.raw.tx = x;
		this.raw.ty = y;
		return this;
	}

	public function prependTransform(transform:ArpTransform):ArpTransform {
		var matrix:MatrixImpl = transform.raw.clone();
		matrix.concat(this.raw);
		this.impl = matrix;
		return this;
	}

	public function prependXY(x:Float, y:Float):ArpTransform {
		this.raw.translate(x * this.raw.a + y * this.raw.c, x * this.raw.b + y * this.raw.d);
		return this;
	}

	public function appendTransform(transform:ArpTransform):ArpTransform {
		this.raw.concat(transform.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):ArpTransform {
		this.raw.translate(x, y);
		return this;
	}
}

#end
