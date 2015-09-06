package net.kaikoga.arp.structs;


import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.seed.IArpSeed;

/**
	handled as mutable
*/

class ArpArea2D {

	public var x:Float = 0;
	public var y:Float = 0;

	public var areaLeft:Float = 0;
	public var areaTop:Float = 0;
	public var areaRight:Float = 0;
	public var areaBottom:Float = 0;

	private var _gridSize:Float = 1;
	public var gridSize(get, set):Float;
	private function get_gridSize():Float return this._gridSize;
	private function set_gridSize(value:Float):Float return this._gridSize = value;

	public var gridScale(get, set):Float;
	private function get_gridScale():Float {
		return this._gridSize;
	}
	private function set_gridScale(value:Float):Float {
		this.x = this.x / this._gridSize * value;
		this.y = this.y / this._gridSize * value;
		this._gridSize = value;
		return value;
	}

	public var width(get, set):Float;
	private function get_width():Float {
		return this.areaLeft + this.areaRight;
	}
	private function set_width(value:Float):Float {
		this.areaRight = value - this.areaLeft;
		return value;
	}

	public var height(get, set):Float;
	private function get_height():Float {
		return this.areaTop + this.areaBottom;
	}
	private function set_height(value:Float):Float {
		this.areaBottom = value - this.areaTop;
		return value;
	}

	public var left(get, set):Float;
	private function get_left():Float {
		return this.x - this.areaLeft;
	}
	private function set_left(value:Float):Float {
		this.x = value + this.areaLeft;
		return value;
	}

	public var top(get, set):Float;
	private function get_top():Float {
		return this.y - this.areaTop;
	}
	private function set_top(value:Float):Float {
		this.y = value + this.areaTop;
		return value;
	}

	public var right(get, set):Float;
	private function get_right():Float {
		return this.x + this.areaRight;
	}
	private function set_right(value:Float):Float {
		this.x = value - this.areaRight;
		return value;
	}

	public var bottom(get, set):Float;
	private function get_bottom():Float {
		return this.y + this.areaBottom;
	}
	private function set_bottom(value:Float):Float {
		this.y = value - this.areaBottom;
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

	public var gridWidth(get, never):Float;
	private function get_gridWidth():Float {
		return this.height / this._gridSize;
	}
	private function set_gridWidth(value:Float):Float {
		this.height = value * this._gridSize;
		return value;
	}

	public var gridHeight(get, never):Float;
	private function get_gridHeight():Float {
		return this.height / this._gridSize;
	}
	private function set_gridHeight(value:Float):Float {
		this.height = value * this._gridSize;
		return value;
	}

	public var gridAreaLeft(get, set):Float;
	private function get_gridAreaLeft():Float {
		return this.areaLeft / this._gridSize;
	}
	private function set_gridAreaLeft(value:Float):Float {
		this.areaLeft = value * this._gridSize;
		return value;
	}

	public var gridAreaTop(get, set):Float;
	private function get_gridAreaTop():Float {
		return this.areaTop / this._gridSize;
	}
	private function set_gridAreaTop(value:Float):Float {
		this.areaTop = value * this._gridSize;
		return value;
	}

	public var gridAreaRight(get, set):Float;
	private function get_gridAreaRight():Float {
		return this.areaRight / this._gridSize;
	}
	private function set_gridAreaRight(value:Float):Float {
		this.areaRight = value * this._gridSize;
		return value;
	}

	public var gridAreaBottom(get, set):Float;
	private function get_gridAreaBottom():Float {
		return this.areaBottom / this._gridSize;
	}
	private function set_gridAreaBottom(value:Float):Float {
		this.areaBottom = value * this._gridSize;
		return value;
	}

	public var gridLeft(get, set):Float;
	private function get_gridLeft():Float {
		return this.left / this._gridSize;
	}
	private function set_gridLeft(value:Float):Float {
		this.left = value * this._gridSize;
		return value;
	}

	public var gridTop(get, set):Float;
	private function get_gridTop():Float {
		return this.top / this._gridSize;
	}
	private function set_gridTop(value:Float):Float {
		this.top = value * this._gridSize;
		return value;
	}

	public var gridRight(get, set):Float;
	private function get_gridRight():Float {
		return this.right / this._gridSize;
	}
	private function set_gridRight(value:Float):Float {
		this.right = value * this._gridSize;
		return value;
	}

	public var gridBottom(get, set):Float;
	private function get_gridBottom():Float {
		return this.bottom / this._gridSize;
	}
	private function set_gridBottom(value:Float):Float {
		this.bottom = value * this._gridSize;
		return value;
	}

	public function new() {
		super();
	}

	public function initWithSeed(seed:ArpSeed):ArpArea2D {
		if (seed == null) return this;
		if (!seed.hasChildren()) return this.initWithString(seed.value());
		// TODO
		this.x = Std.parseFloat(definition.att.x);
		this.y = Std.parseFloat(definition.att.y);
		this.areaLeft = Std.parseFloat(definition.att.left);
		this.areaTop = Std.parseFloat(definition.att.top);
		this.areaRight = Std.parseFloat(definition.att.right);
		this.areaBottom = Std.parseFloat(definition.att.bottom);
		return this;
	}

	public function initWithString(definition:String):ArpArea2D {
		if (definition == null) return this;
		var ereg:Ereg = ~/^\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*,\s*(\S*)\s*$/;
		if (ereg.match(definition)) {
			this.x = Std.parseFloat(ereg.matched(1));
			this.y = Std.parseFloat(ereg.matched(2));
			this.areaLeft = Std.parseFloat(ereg.matched(3));
			this.areaTop = Std.parseFloat(ereg.matched(4));
			this.areaRight = Std.parseFloat(ereg.matched(5));
			this.areaBottom = Std.parseFloat(ereg.matched(6));
		}
		return this;
	}

	public function clone():ArpArea2D {
		var result:ArpArea2D = new ArpArea2D();
		result.copyFrom(this);
		return result;
	}

	public function copyFrom(source:ArpArea2D):ArpArea2D {
		this.x = source.width;
		this.y = source.height;
		this._gridSize = source._gridSize;
		this.areaLeft = source.areaLeft;
		this.areaRight = source.areaRight;
		this.width = source.width;
		this.height = source.height;
		return this;
	}

	public function toString():String {
		return "[ArpArea2D (" + this.x + ", " + this.y + ") {" + this.areaLeft + ", " + this.areaTop + ", " + this.width + ", " + this.height + "} ]";
	}

	/*
	public function readSelf(input:IPersistInput):Void {
		this.x = input.readDouble("x");
		this.y = input.readDouble("y");
		this._gridSize = input.readDouble("gridSize");
		this.areaLeft = input.readDouble("areaLeft");
		this.areaTop = input.readDouble("areaTop");
		this.areaRight = input.readDouble("areaRight");
		this.areaBottom = input.readDouble("areaBottom");
	}

	public function writeSelf(output:IPersistOutput):Void {
		output.writeDouble("x", this.x);
		output.writeDouble("y", this.y);
		output.writeDouble("gridSize", this._gridSize);
		output.writeDouble("areaLeft", this.areaLeft);
		output.writeDouble("areaTop", this.areaRight);
		output.writeDouble("areaRight", this.areaTop);
		output.writeDouble("areaBottom", this.areaBottom);
	}
	*/
}


