package net.kaikoga.arp;

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
	}
}
