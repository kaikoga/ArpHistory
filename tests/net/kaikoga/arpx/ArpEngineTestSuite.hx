package net.kaikoga.arpx;

import net.kaikoga.arpx.paramsOp.ParamsOpCase;
import net.kaikoga.arpx.driver.LinearDriverCase;
import net.kaikoga.arpx.automaton.AutomatonCase;
import net.kaikoga.arpx.text.ParametrizedTextDataCase;
import net.kaikoga.arpx.text.TextDataCase;

import picotest.PicoTestRunner;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpEngineComponentsCase);

		r.load(AutomatonCase);

		r.load(LinearDriverCase);

		r.load(ParamsOpCase);

		r.load(TextDataCase);
		r.load(ParametrizedTextDataCase);
	}
}
