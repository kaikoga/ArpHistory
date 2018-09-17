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
		var v:MatrixImpl = this.impl;
		v._11 = a;
		v._12 = c;
		v._13 = 0;
		v._14 = 0;
		v._21 = b;
		v._22 = d;
		v._23 = 0;
		v._24 = 0;
		v._31 = 0;
		v._32 = 0;
		v._33 = 0;
		v._34 = 0;
		v._41 = tx;
		v._42 = ty;
		v._43 = 0;
		v._44 = 1;
		return this;
	}

	inline public function readData(data:Array<Float>):ArpTransform {
		if (data.length < 6) return this;
		this.reset(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.impl._11;
		data[1] = this.impl._21;
		data[2] = this.impl._12;
		data[3] = this.impl._22;
		data[4] = this.impl._41;
		data[5] = this.impl._42;
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
		pt.set(x, y, 0.);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.impl._11 == 1 && this.impl._12 == 0 && this.impl._21 == 0 && this.impl._22 == 1) {
			return setOrAllocPointImpl(this.impl._41, this.impl._42, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.impl._41, this.impl._42, pt);
	}

	public function setXY(x:Float, y:Float):ArpTransform {
		this.impl._41 = x;
		this.impl._42 = y;
		return this;
	}

	public function prependTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(transform.impl.raw, this.impl.raw);
		return this;
	}

	public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl._41 += x * this.impl._11 + y * this.impl._21;
		this.impl._42 += x * this.impl._12 + y * this.impl._22;
		return this;
	}

	public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(this.impl.raw, transform.impl.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl._41 += x;
		this.impl._42 += y;
		return this;
	}
}

#end
