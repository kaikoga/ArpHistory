package net.kaikoga.arp.hit;

import net.kaikoga.arp.hit.fields.HitFieldSphereCase;
import net.kaikoga.arp.hit.fields.HitFieldAABBCase;
import net.kaikoga.arp.hit.strategies.HitWithAABBCase;
import net.kaikoga.arp.hit.strategies.HitWithSphereCase;

import picotest.PicoTestRunner;

class ArpHitTestTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(HitWithAABBCase);
		r.load(HitWithSphereCase);
		r.load(HitFieldAABBCase);
		r.load(HitFieldSphereCase);
	}

}
