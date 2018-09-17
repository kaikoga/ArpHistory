package arpx.impl.cross.geom;

import h3d.Matrix;

import arp.persistable.IPersistOutput;
import arp.persistable.IPersistInput;
import arp.seed.ArpSeed;
import arpx.impl.cross.geom.MatrixImpl;
import arpx.impl.cross.geom.PointImpl;

class ArpTransformBase {

	public var impl(default, null):MatrixImpl;

	// XXX
	// public var raw(get, never):Matrix;
	// inline private function get_raw():Matrix return impl.raw;

	public function new() {
		this.impl = new MatrixImpl(new Matrix());
		this.impl.identity();
	}

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):ArpTransform {
		this.impl.reset2d(a, b, c, d, tx, ty);
		return cast this;
	}

	public function initWithSeed(seed:ArpSeed):ArpTransform {
		if (seed == null) return cast this;
		if (seed.isSimple) return this.initWithString(seed.value, seed.env.getUnit);

		var xx:Float = 1.0;
		var yx:Float = 0.0;
		var xy:Float = 0.0;
		var yy:Float = 1.0;
		var tx:Float = 0.0;
		var ty:Float = 0.0;
		for (child in seed) {
			switch (child.typeName) {
				case "a", "xx": xx = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 1.0);
				case "b", "yx": yx = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 0.0);
				case "c", "xy": xy = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 0.0);
				case "d", "yy": yy = arp.utils.ArpStringUtil.parseFloatDefault(child.value, 1.0);
				case "x", "tx": tx = arp.utils.ArpStringUtil.parseRichFloat(child.value, seed.env.getUnit);
				case "y", "ty": ty = arp.utils.ArpStringUtil.parseRichFloat(child.value, seed.env.getUnit);
			}
		}
		return this.reset(xx, yx, xy, yy, tx, ty);
	}

	public function initWithString(definition:String, getUnit:String->Float):ArpTransform {
		if (definition == null) return cast this;
		var array:Array<String> = ~/[;,]/g.split(definition);
		if (array.length < 6) return cast this;
		var xx = arp.utils.ArpStringUtil.parseFloatDefault(array[0], 1.0);
		var yx = arp.utils.ArpStringUtil.parseFloatDefault(array[1], 0.0);
		var xy = arp.utils.ArpStringUtil.parseFloatDefault(array[2], 0.0);
		var yy = arp.utils.ArpStringUtil.parseFloatDefault(array[3], 1.0);
		var tx = arp.utils.ArpStringUtil.parseRichFloat(array[4], getUnit);
		var ty = arp.utils.ArpStringUtil.parseRichFloat(array[5], getUnit);
		return this.reset(xx, yx, xy, yy, tx, ty);
	}

	public function readSelf(input:IPersistInput):Void {
		this.reset(
			input.readDouble("xx"),
			input.readDouble("yx"),
			input.readDouble("xy"),
			input.readDouble("yy"),
			input.readDouble("tx"),
			input.readDouble("ty")
		);
	}

	public function writeSelf(output:IPersistOutput):Void {
		var array:Array<Float> = this.toData();
		output.writeDouble("xx", this.impl.xx);
		output.writeDouble("yx", this.impl.yx);
		output.writeDouble("xy", this.impl.xy);
		output.writeDouble("yy", this.impl.yy);
		output.writeDouble("tx", this.impl.tx);
		output.writeDouble("ty", this.impl.ty);
	}

	inline public function readData(data:Array<Float>):ArpTransform {
		if (data.length < 6) return cast this;
		this.impl.reset2d(data[0], data[1], data[2], data[3], data[4], data[5]);
		return cast this;
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
		return new ArpTransform().copyFrom(cast this);
	}

	public function copyFrom(source:ArpTransform):ArpTransform {
		this.impl.copyFrom(source.impl.raw);
		return cast this;
	}

	public function readPoint(pt:PointImpl):ArpTransform {
		this.impl.reset2d(1, 0, 0, 1, pt.x, pt.y);
		return cast this;
	}

	public function readMatrix(matrix:MatrixImpl):ArpTransform {
		this.impl.copyFrom(matrix.raw);
		return cast this;
	}

	inline private function setOrAllocPointImpl(x:Float, y:Float, pt:PointImpl = null) {
		if (pt == null) return PointImpl.alloc(x, y);
		pt.reset(x, y, 0);
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
		return cast this;
	}

	public function prependTransform(transform:ArpTransform):ArpTransform {
		this.impl.prependMatrix(transform.impl);
		return cast this;
	}

	public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl.prependXY(x, y);
		return cast this;
	}

	public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.appendMatrix(transform.impl);
		return cast this;
	}

	public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl.appendXY(x, y);
		return cast this;
	}
}
