package net.kaikoga.arp.hit.structs;

/**
* handled as mutable
*/
class HitGeneric {

	public var r:Float;
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var sizeX:Float;
	public var normXx:Float;
	public var normXy:Float;
	public var normXz:Float;
	public var sizeY:Float;
	public var normYx:Float;
	public var normYy:Float;
	public var normYz:Float;
	public var sizeZ:Float;
	public var normZx:Float;
	public var normZy:Float;
	public var normZz:Float;

	public function new() {
	}

	public function setSphere(r:Float, x:Float, y:Float, z:Float):HitGeneric {
		this.r = r;
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}

	public function setAABB(x:Float, y:Float, z:Float, sizeX, sizeY, sizeZ):HitGeneric {
		this.x = x;
		this.y = y;
		this.z = z;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		this.sizeZ = sizeZ;
		return this;
	}
}
