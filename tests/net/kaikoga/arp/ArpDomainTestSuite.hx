package net.kaikoga.arp;

import net.kaikoga.arp.structs.ArpColorCase;
import net.kaikoga.arp.structs.ArpDirectionCase;
import net.kaikoga.arp.structs.ArpPositionCase;
import net.kaikoga.arp.structs.ArpRangeCase;
import net.kaikoga.arp.structs.ArpParamsCase;
import net.kaikoga.arp.domain.query.ArpDirectoryQueryCase;
import net.kaikoga.arp.domain.query.ArpObjectQueryCase;
import net.kaikoga.arp.domain.seed.ArpSeedCase;
import net.kaikoga.arp.domain.ArpDomainCase;

import picotest.PicoTestRunner;

class ArpDomainTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpSeedCase);
		r.load(ArpDomainCase);
		r.load(ArpDirectoryQueryCase);
		r.load(ArpObjectQueryCase);

		r.load(ArpColorCase);
		r.load(ArpDirectionCase);
		r.load(ArpParamsCase);
		r.load(ArpPositionCase);
		r.load(ArpRangeCase);
	}
}
