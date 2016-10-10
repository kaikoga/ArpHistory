package net.kaikoga.arp.hit.structs;

/**
* handled as mutable
*/
class HitSphere {

	public var r:Float = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var z:Float = 0;

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
