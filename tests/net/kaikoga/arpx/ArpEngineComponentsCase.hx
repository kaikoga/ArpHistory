package net.kaikoga.arpx;

import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.shadow.Shadow;
import net.kaikoga.arpx.text.TextResource;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.text.FixedTextResource;
import net.kaikoga.arpx.text.ParametrizedTextResource;
import net.kaikoga.arpx.chip.RectChip;

import picotest.PicoAssert.*;

class ArpEngineComponentsCase {

	public function testFields() {
		assertNotNull(new Camera());

		assertNotNull(new Chip());
		assertNotNull(new RectChip());

		assertNotNull(new Console());

		assertNotNull(new Shadow());
		assertNotNull(new ChipShadow());
		assertNotNull(new CompositeShadow());

		assertNotNull(new TextResource());
		assertNotNull(new FixedTextResource());
		assertNotNull(new ParametrizedTextResource());
	}

}
