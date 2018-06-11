package arp.hit.strategies;

import arp.hit.structs.HitGeneric;

class HitWithCuboid implements IHitTester<HitGeneric> {

	public function new() {
	}

	public function createHit():HitGeneric {
		return new HitGeneric();
	}

	public function collides(a:HitGeneric, b:HitGeneric):Bool {
		if (Math.abs(a.x - b.x) >= a.sizeX + b.sizeX) return false;
		if (Math.abs(a.y - b.y) >= a.sizeY + b.sizeY) return false;
		if (Math.abs(a.z - b.z) >= a.sizeZ + b.sizeZ) return false;
		return true;
	}
}
