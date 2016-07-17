package net.kaikoga.arp.structs;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;

/**
	handled as mutable
*/
class ArpPosition implements IPersistable {

	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0;
	public var dir:ArpDirection;

	public var tx:Float = 0;
	public var ty:Float = 0;
	public var tz:Float = 0;
	public var period:Float = 0;

	public function new(x:Float = 0, y:Float = 0, z:Float = 0, dir:Int = 0) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.dir = new ArpDirection(dir);
	}

	public function initWithSeed(seed:ArpSeed):ArpPosition {
		if (seed == null) return this;
		if (seed.isSimple()) return this.initWithString(seed.value(), seed.env().getUnit);

		for (child in seed) {
			switch (child.typeName()) {
				case "x": this.x = ArpStructsUtil.parseRichFloat(child.value(), seed.env().getUnit);
				case "y": this.y = ArpStructsUtil.parseRichFloat(child.value(), seed.env().getUnit);
				case "z": this.z = ArpStructsUtil.parseRichFloat(child.value(), seed.env().getUnit);
				case "dir": this.dir.initWithString(child.value());
			}
		}
		return this;
	}

	public function initWithString(definition:String, getUnit:String->Float):ArpPosition {
		if (definition == null) return this;
		var array:Array<String> = definition.split(",");
		this.x = ArpStructsUtil.parseRichFloat(array[0], getUnit);
		this.y = ArpStructsUtil.parseRichFloat(array[1], getUnit);
		this.z = ArpStructsUtil.parseRichFloat(array[2], getUnit);
		this.dir.valueDegree = ArpStructsUtil.parseFloatDefault(array[3], 0.0);
		return this;
	}

	public function clone():ArpPosition {
		return new ArpPosition(this.x, this.y, this.z, this.dir.value);
	}

	public function copyFrom(source:ArpPosition):ArpPosition {
		this.x = source.x;
		this.y = source.y;
		this.z = source.z;
		this.dir.value = source.dir.value;
		this.tx = source.tx;
		this.ty = source.ty;
		this.tz = source.tz;
		this.period = source.period;
		return this;
	}

	public function toString(gridSize:Float = 1.0):String {
		return "[ArpPosition (" + this.x / gridSize + ", " + this.y / gridSize + ", " + this.z / gridSize + ")]";
	}

	public function relocate(x:Float, y:Float, z:Float = 0, gridSize:Float = 1.0):Void {
		this.x = x * gridSize;
		this.y = y * gridSize;
		this.z = z * gridSize;
		this.period = 0;
	}

	public function toward(period:Float, x:Float, y:Float, z:Float = 0, gridSize:Float = 1.0):Void {
		this.period = period;
		this.tx = x * gridSize;
		this.ty = y * gridSize;
		this.tz = z * gridSize;
		if (this.tx != this.x || this.ty != this.y) {
			var valueRadian:Float = Math.atan2(this.ty - this.y, this.tx - this.x);
			this.dir.valueRadian = valueRadian;
		}
	}

	inline public function relocateD(x:Float = 0, y:Float = 0, z:Float = 0, gridSize:Float = 1.0):Void {
		this.relocate(
			this.x + x * gridSize,
			this.y + y * gridSize,
			this.z + z * gridSize
		);
	}

	inline public function towardD(period:Float, x:Float = 0, y:Float = 0, z:Float = 0, gridSize:Float = 1.0):Void {
		this.toward(
			period,
			this.x + x * gridSize,
			this.y + y * gridSize,
			this.z + z * gridSize
		);
	}

	public function tick():Void {
		if (this.period <= 0) {
			return;
		}
		else if (this.period < 1) {
			this.period = 0;
			this.x = this.tx;
			this.y = this.ty;
			this.z = this.tz;
		}
		else {
			var p:Float = this.period--;
			this.x = (this.x * this.period + this.tx) / p;
			this.y = (this.y * this.period + this.ty) / p;
			this.z = (this.z * this.period + this.tz) / p;
		}
	}

	public function distanceTo(other:ArpPosition):Float {
		return Math.sqrt(this.distanceTo(other));
	}

	public function distance2To(other:ArpPosition):Float {
		var dx:Float = other.x - this.x;
		var dy:Float = other.y - this.y;
		var dz:Float = other.z - this.z;
		return dx * dx + dy * dy + dz * dz;
	}

	public function dirTo(other:ArpPosition):ArpDirection {
		var valueRadian:Float = Math.atan2(other.y - this.y, other.x - this.x);
		return ArpDirection.fromRadian(valueRadian);
	}

	public function readSelf(input:IPersistInput):Void {
		this.x = input.readDouble("x");
		this.y = input.readDouble("y");
		this.z = input.readDouble("z");
		this.dir.readSelf(input);
		this.tx = input.readDouble("tx");
		this.ty = input.readDouble("ty");
		this.tz = input.readDouble("tz");
		this.period = input.readDouble("period");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("x", this.x);
		output.writeDouble("y", this.y);
		output.writeDouble("z", this.z);
		this.dir.writeSelf(output);
		output.writeDouble("tx", this.tx);
		output.writeDouble("ty", this.ty);
		output.writeDouble("tz", this.tz);
		output.writeDouble("period", this.period);
	}
}


