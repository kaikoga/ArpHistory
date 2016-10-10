package net.kaikoga.arp.hit.structs;

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
}
