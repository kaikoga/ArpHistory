package net.kaikoga.arpx;

import net.kaikoga.arpx.automaton.AutomatonCase;
import net.kaikoga.arpx.backends.flash.geom.AMatrixCase;
import net.kaikoga.arpx.backends.flash.geom.APointCase;
import net.kaikoga.arpx.driver.LinearDriverCase;
import net.kaikoga.arpx.input.KeyInputCase;
import net.kaikoga.arpx.paramsOp.RewireParamsOpCase;
import net.kaikoga.arpx.text.ParametrizedTextDataCase;
import net.kaikoga.arpx.text.TextDataCase;
import picotest.PicoTestRunner;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(AMatrixCase);
		r.load(APointCase);

		r.load(ArpEngineComponentsCase);

		r.load(AutomatonCase);

		r.load(LinearDriverCase);

		r.load(KeyInputCase);

		r.load(RewireParamsOpCase);

		r.load(TextDataCase);
		r.load(ParametrizedTextDataCase);
	}
}
