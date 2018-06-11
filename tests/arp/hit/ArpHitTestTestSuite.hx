package arp.hit;

import arp.hit.fields.HitGenerationCase;
import arp.hit.fields.HitObjectFieldSphereCase;
import arp.hit.fields.HitObjectFieldCuboidCase;
import arp.hit.fields.HitFieldSphereCase;
import arp.hit.fields.HitFieldCuboidCase;
import arp.hit.strategies.HitWithCuboidCase;
import arp.hit.strategies.HitWithSphereCase;

import picotest.PicoTestRunner;

class ArpHitTestTestSuite {

	public static function addTo(r:PicoTestRunner) {
		r.load(HitGenerationCase);

		r.load(HitWithCuboidCase);
		r.load(HitWithSphereCase);
		r.load(HitFieldCuboidCase);
		r.load(HitFieldSphereCase);
		r.load(HitObjectFieldCuboidCase);
		r.load(HitObjectFieldSphereCase);
	}

}
