package net.kaikoga.arpx;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.impl.backends.flash.geom.TransformCase;
#end

import net.kaikoga.arpx.automaton.AutomatonCase;
import net.kaikoga.arpx.driver.LinearDriverCase;
import net.kaikoga.arpx.input.KeyInputCase;
import net.kaikoga.arpx.paramsOp.RewireParamsOpCase;
import net.kaikoga.arpx.text.ParametrizedTextDataCase;
import net.kaikoga.arpx.text.TextDataCase;
import picotest.PicoTestRunner;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {

#if (arp_backend_flash || arp_backend_openfl)
		r.load(TransformCase);
#end

		r.load(ArpEngineComponentsCase);

		r.load(AutomatonCase);

		r.load(LinearDriverCase);

		r.load(KeyInputCase);

		r.load(RewireParamsOpCase);

		r.load(TextDataCase);
		r.load(ParametrizedTextDataCase);
	}
}
