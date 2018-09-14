package arpx.impl.heaps.geom;

#if arp_display_backend_heaps

import arp.domain.IArpStruct;
import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;
import arpx.impl.cross.geom.macro.TransformMacros;
import arpx.impl.cross.geom.ITransform;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.MatrixImpl;

@:arpStruct("Transform")
class Transform implements ITransform implements IArpStruct {

	public var raw(default, null):MatrixImpl;

	public function new() {
		this.raw = new MatrixImpl();
		this.raw.identity();
	}

	public function initWithSeed(seed:ArpSeed):Transform TransformMacros.initWithSeed(seed);

	public function initWithString(definition:String, getUnit:String->Float):Transform TransformMacros.initWithString(definition, getUnit);

	public function readSelf(input:IPersistInput):Void TransformMacros.readSelf(input);

	public function writeSelf(output:IPersistOutput):Void TransformMacros.writeSelf(output);

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		var v:MatrixImpl = this.raw;
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

	inline public function readData(data:Array<Float>):Transform {
		if (data.length < 6) return this;
		this.reset(data[0], data[1], data[2], data[3], data[4], data[5]);
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = this.raw._11;
		data[1] = this.raw._21;
		data[2] = this.raw._12;
		data[3] = this.raw._22;
		data[4] = this.raw._41;
		data[5] = this.raw._42;
		return data;
	}

	public function clone():Transform {
		return new Transform().copyFrom(this);
	}

	public function copyFrom(source:Transform):Transform {
		this.raw.load(source.raw);
		return this;
	}

	public function readPoint(pt:PointImpl):Transform {
		this.reset(1, 0, 0, 1, pt.x, pt.y);
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):Transform {
		this.raw.load(matrix);
		return this;
	}

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return new PointImpl(x, y);
		pt.set(x, y, 0.);
		return pt;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		if (this.raw._11 == 1 && this.raw._12 == 0 && this.raw._21 == 0 && this.raw._22 == 1) {
			return setOrAllocPointImpl(this.raw._41, this.raw._42, pt);
		}
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return setOrAllocPointImpl(this.raw._41, this.raw._42, pt);
	}

	public function setXY(x:Float, y:Float):Transform {
		this.raw._41 = x;
		this.raw._42 = y;
		return this;
	}

	public function prependTransform(transform:Transform):Transform {
		this.raw.multiply(transform.raw, this.raw);
		return this;
	}

	public function prependXY(x:Float, y:Float):Transform {
		this.raw._41 += x * this.raw._11 + y * this.raw._21;
		this.raw._42 += x * this.raw._12 + y * this.raw._22;
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		this.raw.multiply(this.raw, transform.raw);
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		this.raw._41 += x;
		this.raw._42 += y;
		return this;
	}
}

#end
