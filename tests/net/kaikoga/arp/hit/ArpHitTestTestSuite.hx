package net.kaikoga.arp.hit;

import net.kaikoga.arp.hit.fields.HitObjectFieldSphereCase;
import net.kaikoga.arp.hit.fields.HitObjectFieldCuboidCase;
import net.kaikoga.arp.hit.fields.HitFieldSphereCase;
import net.kaikoga.arp.hit.fields.HitFieldCuboidCase;
import net.kaikoga.arp.hit.strategies.HitWithCuboidCase;
import net.kaikoga.arp.hit.strategies.HitWithSphereCase;

import picotest.PicoTestRunner;

class ArpHitTestTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(HitWithCuboidCase);
		r.load(HitWithSphereCase);
		r.load(HitFieldCuboidCase);
		r.load(HitFieldSphereCase);
		r.load(HitObjectFieldCuboidCase);
		r.load(HitObjectFieldSphereCase);
	}

}
