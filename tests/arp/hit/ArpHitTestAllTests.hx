package arp.hit;

import picotest.PicoTest;

class ArpHitTestAllTests {
	static function main() {
		var r = PicoTest.runner();
		ArpHitTestTestSuite.addTo(r);
		r.run();
	}
}
