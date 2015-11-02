package net.kaikoga.arp.structs;

import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.persistable.IPersistOutput;
import net.kaikoga.arp.persistable.IPersistInput;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpPosition;

/**
	* handled as immutable
	* @author kaikoga
*/
class ArpHitArea implements IPersistable {

	public var areaLeft:Float = 0;
	public var areaRight:Float = 1;
	public var areaTop:Float = 0;
	public var areaBottom:Float = 1;
	public var areaHind:Float = 0;
	public var areaFore:Float = 1;

	private var _gridSize:Float = 1;
	public var gridSize(get, set):Float;
	private function get_gridSize():Float return this._gridSize;
	private function set_gridSize(value:Float):Float return this._gridSize = value;

	public var gridScale(get, set):Float;
	private function get_gridScale():Float {
		return this._gridSize;
	}
	private function set_gridScale(value:Float):Float {
		this.areaLeft = this.areaLeft / this._gridSize * value;
		this.areaRight = this.areaRight / this._gridSize * value;
		this.areaTop = this.areaTop / this._gridSize * value;
		this.areaBottom = this.areaBottom / this._gridSize * value;
		this.areaHind = this.areaHind / this._gridSize * value;
		this.areaFore = this.areaFore / this._gridSize * value;
		this._gridSize = value;
		return value;
	}

	public var width(get, never):Float;
	private function get_width():Float {
		return this.areaLeft + this.areaRight;
	}
	//private function set_width(value:Float):Void {
	//this.areaRight = value - this.areaLeft;
	//}

	public var height(get, never):Float;
	private function get_height():Float {
		return this.areaTop + this.areaBottom;
	}
	//private function set_height(value:Float):Void {
	//this.areaBottom = value - this.areaTop;
	//}

	public var depth(get, never):Float;
	private function get_depth():Float {
		return this.areaHind + this.areaFore;
	}
	//private function set_depth(value:Float):Void {
	//this.areaFore = value - this.areaHind;
	//}

	public function new() {
	}

	public function initWithSeed(seed:ArpSeed):ArpHitArea {
		if (seed == null) return this;
		if (!seed.hasChildren()) return this.initWithString(seed.value());
		this.areaLeft = 0;
		this.areaRight = 1;
		this.areaTop = 0;
		this.areaBottom = 1;
		this.areaHind = 0;
		this.areaFore = 1;
		for (element in seed) {
			switch (element.typeName()) {
				case "left":
					this.areaLeft = Std.parseFloat(element.value());
				case "right":
					this.areaRight = Std.parseFloat(element.value());
				case "top":
					this.areaTop = Std.parseFloat(element.value());
				case "bottom":
					this.areaBottom = Std.parseFloat(element.value());
				case "hind":
					this.areaHind = Std.parseFloat(element.value());
				case "fore":
					this.areaFore = Std.parseFloat(element.value());
			}
		}
		for (element in seed) {
			switch (element.typeName()) {
				case "width":
					this.areaRight = Std.parseFloat(element.value()) - this.areaLeft;
				case "height":
					this.areaBottom = Std.parseFloat(element.value()) - this.areaTop;
				case "depth":
					this.areaFore = Std.parseFloat(element.value()) - this.areaHind;
			}
		}
		return this;
	}

	public function initWithString(definition:String):ArpHitArea {
		if (definition == null) return this;
		var ereg:EReg = ~/^\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*$/;
		if (ereg.match(definition)) {
			this.areaLeft = Std.parseFloat(ereg.matched(1));
			this.areaTop = Std.parseFloat(ereg.matched(2));
			this.areaRight = Std.parseFloat(ereg.matched(3));
			this.areaBottom = Std.parseFloat(ereg.matched(4));
			this.areaHind = Std.parseFloat(ereg.matched(5));
			this.areaFore = Std.parseFloat(ereg.matched(6));
		}
		return this;
	}

	public function clone():ArpHitArea {
		var result:ArpHitArea = new ArpHitArea();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpHitArea):ArpHitArea {
		this.areaLeft = source.areaLeft;
		this.areaRight = source.areaRight;
		this.areaTop = source.areaTop;
		this.areaBottom = source.areaBottom;
		this.areaHind = source.areaHind;
		this.areaFore = source.areaFore;
		return this;
	}

	public function collidesCoordinate(base:ArpPosition, x:Float, y:Float, z:Float):Bool {
		return (
			x >= base.x - this.areaLeft && x < base.x + this.areaRight &&
			y >= base.y - this.areaTop && y < base.y + this.areaBottom &&
			z >= base.z - this.areaHind && z < base.z + this.areaFore);
	}

	public function collidesPosition(base:ArpPosition, position:ArpPosition):Bool {
		return (
			position.x >= base.x - this.areaLeft && position.x < base.x + this.areaRight &&
			position.y >= base.y - this.areaTop && position.y < base.y + this.areaBottom &&
			position.z >= base.z - this.areaHind && position.z < base.z + this.areaFore);
	}

	public function collidesHitArea(base:ArpPosition, targetBase:ArpPosition, target:ArpHitArea):Bool {
		return (
			targetBase.x + target.areaRight > base.x - this.areaLeft && targetBase.x - target.areaLeft < base.x + this.areaRight &&
			targetBase.y + target.areaBottom > base.y - this.areaTop && targetBase.y - target.areaTop < base.y + this.areaBottom &&
			targetBase.z + target.areaFore > base.z - this.areaHind && targetBase.z - target.areaHind < base.z + this.areaFore);
	}

	public function toString():String {
		return "[ArpHitArea {" + this.areaLeft + ".." + this.areaRight + "," + this.areaTop + ".." + this.areaBottom + "," + this.areaHind + ".." + this.areaFore + "} ]";
	}

	public function readSelf(input:IPersistInput):Void {
		this.areaLeft = input.readDouble("areaLeft");
		this.areaRight = input.readDouble("areaRight");
		this.areaTop = input.readDouble("areaTop");
		this.areaBottom = input.readDouble("areaBottom");
		this.areaHind = input.readDouble("areaHind");
		this.areaFore = input.readDouble("areaFore");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("areaLeft", this.areaLeft);
		output.writeDouble("areaRight", this.areaRight);
		output.writeDouble("areaTop", this.areaTop);
		output.writeDouble("areaBottom", this.areaBottom);
		output.writeDouble("areaHind", this.areaHind);
		output.writeDouble("areaFore", this.areaFore);
	}
}


