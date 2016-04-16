package net.kaikoga.arpx;

import net.kaikoga.arpx.chip.GridChip;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.shadow.Shadow;
import net.kaikoga.arpx.text.TextData;
import net.kaikoga.arpx.console.Console;
import net.kaikoga.arpx.shadow.ChipShadow;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arpx.text.FixedTextData;
import net.kaikoga.arpx.text.ParametrizedTextData;
import net.kaikoga.arpx.chip.RectChip;

import picotest.PicoAssert.*;

class ArpEngineComponentsCase {

	public function testFields() {
		assertNotNull(new Camera());

		assertNotNull(new Chip());
		assertNotNull(new RectChip());
		assertNotNull(new GridChip());

		assertNotNull(new Console());

		assertNotNull(new Shadow());
		assertNotNull(new ChipShadow());
		assertNotNull(new CompositeShadow());

		assertNotNull(new TextData());
		assertNotNull(new FixedTextData());
		assertNotNull(new ParametrizedTextData());
	}

}
