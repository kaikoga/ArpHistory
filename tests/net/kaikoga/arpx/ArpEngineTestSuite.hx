package net.kaikoga.arpx;

import net.kaikoga.arpx.text.ParametrizedTextResourceCase;
import net.kaikoga.arpx.text.TextResourceCase;

import picotest.PicoTestRunner;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpEngineComponentsCase);
		r.load(TextResourceCase);
		r.load(ParametrizedTextResourceCase);
	}
}
