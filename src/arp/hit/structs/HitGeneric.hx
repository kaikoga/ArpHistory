package arp.hit.structs;

/**
* handled as mutable
*/
class HitGeneric {

	public var r:Float = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0;
	public var sizeX:Float = 0;
	public var normXx:Float = 0;
	public var normXy:Float = 0;
	public var normXz:Float = 0;
	public var sizeY:Float = 0;
	public var normYx:Float = 0;
	public var normYy:Float = 0;
	public var normYz:Float = 0;
	public var sizeZ:Float = 0;
	public var normZx:Float = 0;
	public var normZy:Float = 0;
	public var normZz:Float = 0;

	public function new() {
	}

	public function setSphere(r:Float, x:Float, y:Float, z:Float):HitGeneric {
		this.r = r;
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

	public function setCuboid(x:Float, y:Float, z:Float, sizeX, sizeY, sizeZ):HitGeneric {
		this.x = x;
		this.y = y;
		this.z = z;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		this.sizeZ = sizeZ;
		return this;
	}

	public function toString():String {
		var result:String = "{";
		var bitmap:Int = 0;
		if (r != 0) bitmap |= 0x1;
		if (x != 0) bitmap |= 0x2;
		if (y != 0) bitmap |= 0x4;
		if (z != 0) bitmap |= 0x8;
		if (sizeX != 0) bitmap |= 0x10;
		if (normXx != 0) bitmap |= 0x20;
		if (normXy != 0) bitmap |= 0x40;
		if (normXz != 0) bitmap |= 0x80;
		if (sizeY != 0) bitmap |= 0x100;
		if (normYx != 0) bitmap |= 0x200;
		if (normYy != 0) bitmap |= 0x400;
		if (normYz != 0) bitmap |= 0x800;
		if (sizeZ != 0) bitmap |= 0x1000;
		if (normZx != 0) bitmap |= 0x2000;
		if (normZy != 0) bitmap |= 0x4000;
		if (normZz != 0) bitmap |= 0x8000;
		if (bitmap & 0xe != 0) {
			if (bitmap & 0x8 == 0) {
				result += '$x,$y';
			} else {
				result += '$x,$y,$z';
			}
		}
		if (bitmap & 0xfff1 != 0) {
			result += '}*{';
			if (bitmap & 0x1 != 0) {
				result += '($r)';
			}
			if (bitmap & 0xfff0 != 0) {
				result += '$sizeX,$sizeY,$sizeZ';
				if (bitmap & 0xeee0 != 0) {
					result += ':$normXx,$normXy,$normXz;$normYx,$normYy,$normYz;$normZx,$normZy,$normZz';
				}
			}
		}
		result += "}";
		return result;
	}
}
