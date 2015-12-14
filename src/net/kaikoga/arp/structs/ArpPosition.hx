package net.kaikoga.arp.structs;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.IFrameMove;

/**
	handled as mutable
*/
class ArpPosition implements IFrameMove implements IPersistable {

	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0;
	public var dir:ArpDirection;

	public var tx:Float = 0;
	public var ty:Float = 0;
	public var tz:Float = 0;
	public var period:Float = 0;

	private var _gridSize:Float = 1;
	private var _explicitGridSize:Float = 1;
	public var gridSize(get, set):Float;
	private function get_gridSize():Float {
		return this._explicitGridSize;
	}
	private function set_gridSize(value:Float):Float {
		this._explicitGridSize = value;
		this._gridSize = (value != 0) ? value : 1;
		return value;
	}

	public var gridScale(get, set):Float;
	private function get_gridScale():Float {
		return this._explicitGridSize;
	}
	private function set_gridScale(value:Float):Float {
		if (value != 0) {
			//input is non-zero
			if (this._explicitGridSize != 0) {
				//do scaling only if explicit grid size is non-zero
				value = (value != 0) ? value : 1;
				this.x = this.x / this._gridSize * value;
				this.y = this.y / this._gridSize * value;
				this.z = this.z / this._gridSize * value;
			}
			this._explicitGridSize = value;
			this._gridSize = value;
		}
		else {
			//input is zero
			this._explicitGridSize = 0;
			this._gridSize = 1;
		}
		return value;
	}

	public var gridX(get, set):Float;
	private function get_gridX():Float {
		return this.x / this._gridSize;
	}
	private function set_gridX(value:Float):Float {
		this.x = value * this._gridSize;
		return value;
	}

	public var gridY(get, set):Float;
	private function get_gridY():Float {
		return this.y / this._gridSize;
	}
	private function set_gridY(value:Float):Float {
		this.y = value * this._gridSize;
		return value;
	}


	public var gridZ(get, set):Float;
	private function get_gridZ():Float {
		return this.z / this._gridSize;
	}
	private function set_gridZ(value:Float):Float {
		this.z = value * this._gridSize;
		return value;
	}

	public var gridTx(get, set):Float;
	private function get_gridTx():Float {
		return this.tx / this._gridSize;
	}
	private function set_gridTx(value:Float):Float {
		this.tx = value * this._gridSize;
		return value;
	}

	public var gridTy(get, set):Float;
	private function get_gridTy():Float {
		return this.ty / this._gridSize;
	}
	private function set_gridTy(value:Float):Float {
		this.ty = value * this._gridSize;
		return value;
	}

	public var gridTz(get, set):Float;
	private function get_gridTz():Float {
		return this.tz / this._gridSize;
	}
	private function set_gridTz(value:Float):Float {
		this.tz = value * this._gridSize;
		return value;
	}

	public function new(x:Float = 0, y:Float = 0, z:Float = 0, dir:Int = 0, gridSize:Float = 1) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.dir = new ArpDirection(dir);
		this.gridSize = gridSize;
	}

	public function initWithSeed(seed:ArpSeed):ArpPosition {
		if (seed == null) return this;
		if (seed.isSimple()) return this.initWithString(seed.value());

		this._gridSize = 1;
		this._explicitGridSize = 0;
		for (child in seed) {
			switch (child.typeName()) {
				case "x": this.x = Std.parseFloat(child.value());
				case "y": this.y = Std.parseFloat(child.value());
				case "z": this.z = Std.parseFloat(child.value());
				case "gridX": this.x = Std.parseFloat(child.value()); this._explicitGridSize = 1;
				case "gridY": this.y = Std.parseFloat(child.value()); this._explicitGridSize = 1;
				case "gridZ": this.z = Std.parseFloat(child.value()); this._explicitGridSize = 1;
				case "dir": this.dir.initWithString(child.value());
			}
		}
		return this;
	}

	public function initWithString(definition:String):ArpPosition {
		if (definition == null) return this;
		this._gridSize = 1;
		if (definition.charAt(0) == "g") {
			this._explicitGridSize = 1;
			definition = definition.substring(1);
		}
		else {
			this._explicitGridSize = 0;
		}
		var ereg:EReg = ~/[^-0-9.]+/g;
		var array:Array<String> = ereg.split(definition);
		this.x = ArpStructsUtil.parseFloatDefault(array[0], 0.0);
		this.y = ArpStructsUtil.parseFloatDefault(array[1], 0.0);
		this.z = ArpStructsUtil.parseFloatDefault(array[2], 0.0);
		this.dir.valueDegree = ArpStructsUtil.parseFloatDefault(array[3], 0.0);
		return this;
	}

	public function clone():ArpPosition {
		return new ArpPosition(this.x, this.y, this.z, this.dir.value, this._gridSize);
	}

	public function copyFrom(source:ArpPosition):ArpPosition {
		this.x = source.x;
		this.y = source.y;
		this.z = source.z;
		this._gridSize = source._gridSize;
		this._explicitGridSize = source._explicitGridSize;
		this.dir.value = source.dir.value;
		this.tx = source.tx;
		this.ty = source.ty;
		this.tz = source.tz;
		this.period = source.period;
		return this;
	}

	public function toString(byGrid:Bool = false):String {
		if (byGrid) {
			return "[ArpPosition (" + this.gridX + ", " + this.gridY + ", " + this.gridZ + ")]";
		}
		return "[ArpPosition (" + this.x + ", " + this.y + ", " + this.z + ")]";
	}

	public function relocate(x:Float, y:Float, z:Float = 0, byGrid:Bool = false):Void {
		if (byGrid) {
			this.gridX = x;
			this.gridY = y;
			this.gridZ = z;
		}
		else {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		this.period = 0;
	}

	public function toward(period:Float, x:Float, y:Float, z:Float = 0, byGrid:Bool = false):Void {
		this.period = period;
		if (byGrid) {
			this.gridTx = x;
			this.gridTy = y;
			this.gridTz = z;
		}
		else {
			this.tx = x;
			this.ty = y;
			this.tz = z;
		}
		if (this.tx != this.x || this.ty != this.y) {
			var valueRadian:Float = Math.atan2(this.ty - this.y, this.tx - this.x);
			this.dir.valueRadian = valueRadian;
		}
	}

	public function relocateD(x:Float = 0, y:Float = 0, z:Float = 0, byGrid:Bool = false):Void {
		if (byGrid) {
			this.relocate(
				x + this.gridX,
				y + this.gridY,
				z + this.gridZ,
				true
			);
		}
		else {
			this.relocate(
				x + this.x,
				y + this.y,
				z + this.z,
				false
			);
		}
	}

	public function towardD(period:Float, x:Float = 0, y:Float = 0, z:Float = 0, byGrid:Bool = false):Void {
		if (byGrid) {
			this.toward(
				period,
				x + this.gridX,
				y + this.gridY,
				z + this.gridZ,
				true
			);
		}
		else {
			this.toward(
				period,
				x + this.x,
				y + this.y,
				z + this.z,
				false
			);
		}
	}

	public function frameMove():Void {
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
		this.gridSize = input.readDouble("gridSize");
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
		output.writeDouble("gridSize", this.gridSize);
		this.dir.writeSelf(output);
		output.writeDouble("tx", this.tx);
		output.writeDouble("ty", this.ty);
		output.writeDouble("tz", this.tz);
		output.writeDouble("period", this.period);
	}
}


