package arp.hit.strategies;

import arp.hit.structs.HitSphere;

class HitWithSphere implements IHitTester<HitSphere> {

	public function new() {
	}

	public function createHit():HitSphere {
		return new HitSphere();
	}

	public function collides(a:HitSphere, b:HitSphere):Bool {
		var dr:Float = a.r + b.r;
		var dx:Float = a.x - b.x;
		var dy:Float = a.y - b.y;
		var dz:Float = a.z - b.z;
		return (dx * dx + dy * dy + dz * dz) < dr * dr;
	}
}
