package net.kaikoga.arp.hit.structs;

/**
* handled as mutable
*/
class HitSphere {

	public var r:Float;
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public function new() {
	}

	public function setSphere(r:Float, x:Float, y:Float, z:Float):HitSphere {
		this.r = r;
		this.x = x;
		this.y = y;
		this.z = z;
		return this;
	}
}
