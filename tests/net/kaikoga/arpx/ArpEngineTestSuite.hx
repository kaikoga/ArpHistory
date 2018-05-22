package net.kaikoga.arpx;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.impl.backends.flash.geom.TransformCase;
#end

import net.kaikoga.arpx.macro.ArpStructsMacroArpObjectCase;
import net.kaikoga.arpx.structs.ArpColorFlashCase;
import net.kaikoga.arpx.structs.ArpRangeCase;
import net.kaikoga.arpx.structs.ArpPositionCase;
import net.kaikoga.arpx.structs.ArpParamsCase;
import net.kaikoga.arpx.structs.ArpDirectionCase;
import net.kaikoga.arpx.structs.ArpColorCase;
import net.kaikoga.arpx.automaton.AutomatonCase;
import net.kaikoga.arpx.driver.LinearDriverCase;
import net.kaikoga.arpx.input.KeyInputCase;
import net.kaikoga.arpx.paramsOp.RewireParamsOpCase;
import net.kaikoga.arpx.text.ParametrizedTextDataCase;
import net.kaikoga.arpx.text.TextDataCase;
import picotest.PicoTestRunner;

import net.kaikoga.arp.testParams.PersistIoProviders.*;

class ArpEngineTestSuite {
	public static function addTo(r:PicoTestRunner) {
		r.load(ArpColorCase, persistIoProvider());
		r.load(ArpDirectionCase, persistIoProvider());
		r.load(ArpParamsCase, persistIoProvider());
		r.load(ArpPositionCase, persistIoProvider());
		r.load(ArpRangeCase, persistIoProvider());

		#if (flash || openfl)
		r.load(ArpColorFlashCase);
		#end

		r.load(ArpStructsMacroArpObjectCase);

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
