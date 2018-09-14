package arpx;

#if arp_display_backend_flash
import arpx.impl.flash.geom.ArpTransformFlashCase;
#end

import arpx.impl.cross.geom.ArpTransformCase;
import arpx.macro.ArpStructsMacroArpObjectCase;
import arpx.structs.ArpColorFlashCase;
import arpx.structs.ArpRangeCase;
import arpx.structs.ArpPositionCase;
import arpx.structs.ArpParamsCase;
import arpx.structs.ArpDirectionCase;
import arpx.structs.ArpColorCase;
import arpx.automaton.AutomatonCase;
import arpx.driver.LinearDriverCase;
import arpx.input.KeyInputCase;
import arpx.paramsOp.RewireParamsOpCase;
import arpx.text.ParametrizedTextDataCase;
import arpx.text.TextDataCase;
import picotest.PicoTestRunner;

import arp.testParams.PersistIoProviders.*;

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

		r.load(ArpTransformCase, persistIoProvider());

		#if arp_display_backend_flash
		r.load(ArpTransformFlashCase);
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
