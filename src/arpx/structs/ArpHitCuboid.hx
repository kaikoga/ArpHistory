package arpx.structs;

import arp.persistable.IPersistable;
import arp.persistable.IPersistInput;
import arp.persistable.IPersistOutput;
import arp.seed.ArpSeed;

/**
	* handled as immutable
	* @author kaikoga
*/
@:build(arp.ArpDomainMacros.buildStruct("HitCuboid"))
class ArpHitCuboid implements IPersistable {

	public var dX:Float = 0;
	public var dY:Float = 0;
	public var dZ:Float = 0;
	public var sizeX:Float = 0;
	public var sizeY:Float = 0;
	public var sizeZ:Float = 0;

	private var _gridSize:Float = 1;
	public var gridSize(get, set):Float;
	private function get_gridSize():Float return this._gridSize;
	private function set_gridSize(value:Float):Float return this._gridSize = value;

	public var gridScale(get, set):Float;
	private function get_gridScale():Float {
		return this._gridSize;
	}
	private function set_gridScale(value:Float):Float {
		var f:Float = value / this._gridSize;
		this.dX = this.dX * f;
		this.dY = this.dY * f;
		this.dZ = this.dZ * f;
		this.sizeX = this.sizeX * f;
		this.sizeY = this.sizeY * f;
		this.sizeZ = this.sizeZ * f;
		this._gridSize = value;
		return value;
	}

	public var areaLeft(get, never):Float;
	inline private function get_areaLeft():Float return this.dX - sizeX;
	public var areaRight(get, never):Float;
	inline private function get_areaRight():Float return this.dX + sizeX;
	public var areaTop(get, never):Float;
	inline private function get_areaTop():Float return this.dY - sizeY;
	public var areaBottom(get, never):Float;
	inline private function get_areaBottom():Float return this.dY + sizeY;
	public var areaHind(get, never):Float;
	inline private function get_areaHind():Float return this.dZ - sizeZ;
	public var areaFore(get, never):Float;
	inline private function get_areaFore():Float return this.dZ + sizeZ;

	public function new() {
	}

	public function initWithSeed(seed:ArpSeed):ArpHitCuboid {
		if (seed == null) return this;
		if (seed.isSimple) return this.initWithString(seed.value);
		for (element in seed) {
			switch (element.typeName) {
				case "dX", "x":
					this.dX = Std.parseFloat(element.value);
				case "dY", "y":
					this.dY = Std.parseFloat(element.value);
				case "dZ", "z":
					this.dZ = Std.parseFloat(element.value);
				case "sizeX", "width":
					this.sizeX = Std.parseFloat(element.value);
				case "sizeY", "height":
					this.sizeY = Std.parseFloat(element.value);
				case "sizeZ", "depth":
					this.sizeZ = Std.parseFloat(element.value);
			}
		}
		return this;
	}

	public function initWithString(definition:String):ArpHitCuboid {
		if (definition == null) return this;
		var ereg:EReg = ~/^\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*$/;
		if (ereg.match(definition)) {
			this.dX = Std.parseFloat(ereg.matched(1));
			this.dY = Std.parseFloat(ereg.matched(2));
			this.dZ = Std.parseFloat(ereg.matched(3));
			this.sizeX = Std.parseFloat(ereg.matched(4));
			this.sizeY = Std.parseFloat(ereg.matched(5));
			this.sizeZ = Std.parseFloat(ereg.matched(6));
		}
		return this;
	}

	public function clone():ArpHitCuboid {
		var result:ArpHitCuboid = new ArpHitCuboid();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpHitCuboid):ArpHitCuboid {
		this.dX = source.dX;
		this.dY = source.dY;
		this.dZ = source.dZ;
		this.sizeX = source.sizeX;
		this.sizeY = source.sizeY;
		this.sizeZ = source.sizeZ;
		return this;
	}

	public function toString():String {
		return '[ArpHitArea {$dX,$dY,$dZ}*{$sizeX,$sizeY,$sizeZ}]';
	}

	public function readSelf(input:IPersistInput):Void {
		this.dX = input.readDouble("dX");
		this.dY = input.readDouble("dY");
		this.dZ = input.readDouble("dZ");
		this.sizeX = input.readDouble("sizeX");
		this.sizeY = input.readDouble("sizeY");
		this.sizeZ = input.readDouble("sizeZ");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("dX", this.dX);
		output.writeDouble("dY", this.dY);
		output.writeDouble("dZ", this.dZ);
		output.writeDouble("sizeX", this.sizeX);
		output.writeDouble("sizeY", this.sizeY);
		output.writeDouble("sizeZ", this.sizeZ);
	}
}


