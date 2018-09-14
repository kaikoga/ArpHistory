package arpx.impl.stub.geom;

#if arp_display_backend_stub

import arp.domain.IArpStruct;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;

import arpx.impl.cross.geom.ITransform;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.cross.geom.MatrixImpl;

@:arpStruct("Transform")
class Transform implements ITransform implements IArpStruct {

	public var raw(default, null):MatrixImpl;

	public function new() {
		this.raw = new MatrixImpl();
	}

	public function initWithSeed(seed:ArpSeed):Transform return this;

	public function initWithString(definition:String, getUnit:String->Float):Transform return this;

	public function readSelf(input:IPersistInput):Void return;

	public function writeSelf(output:IPersistOutput):Void return;

	inline public function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform {
		return this;
	}

	inline public function readData(data:Array<Float>):Transform {
		return this;
	}

	inline public function toData(data:Array<Float> = null):Array<Float> {
		if (data == null) data = [];
		data[0] = 1;
		data[1] = 0;
		data[2] = 0;
		data[3] = 1;
		data[4] = 0;
		data[5] = 0;
		return data;
	}

	public function clone():Transform {
		return new Transform();
	}

	public function copyFrom(source:Transform):Transform {
		return this;
	}

	public function readPoint(pt:PointImpl):Transform {
		return this;
	}

	public function readMatrix(matrix:MatrixImpl):Transform {
		return this;
	}

	public function asPoint(pt:PointImpl = null):PointImpl {
		return null;
	}

	public function toPoint(pt:PointImpl = null):PointImpl {
		return new PointImpl();
	}

	public function setXY(x:Float, y:Float):Transform {
		return this;
	}

	public function prependTransform(transform:Transform):Transform {
		return this;
	}

	public function prependXY(x:Float, y:Float):Transform {
		return this;
	}

	public function appendTransform(transform:Transform):Transform {
		return this;
	}

	public function appendXY(x:Float, y:Float):Transform {
		return this;
	}
}

#end
