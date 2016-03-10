package net.kaikoga.arpx;

import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.text.TextResource;
import net.kaikoga.arpx.text.ParametrizedTextResource;
import net.kaikoga.arpx.chip.RectChip;

import picotest.PicoAssert.*;

class ArpEngineComponentsCase {

	public function testFields() {
		assertNotNull(new RectChip());
		assertNotNull(new Console());
		assertNotNull(new ChipShadow());
		assertNotNull(new CompositeShadow());
		assertNotNull(new ParametrizedTextResource());
		assertNotNull(new TextResource());
	}

}
