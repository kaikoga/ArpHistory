package net.kaikoga.arpx;

import net.kaikoga.arpx.text.ParametrizedTextDataCase;
import net.kaikoga.arpx.text.TextDataCase;

import picotest.PicoTestRunner;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpEngineComponentsCase);
		r.load(TextDataCase);
		r.load(ParametrizedTextDataCase);
	}
}