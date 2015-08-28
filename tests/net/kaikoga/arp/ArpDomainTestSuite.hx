package net.kaikoga.arp;

import net.kaikoga.arp.domain.ArpDomainCase;
import picotest.PicoTestRunner;

class ArpDomainTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpDomainCase);
	}
}
