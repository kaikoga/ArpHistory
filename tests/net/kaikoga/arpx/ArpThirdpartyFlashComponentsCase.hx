package net.kaikoga.arpx;

#if flash
import net.kaikoga.arpx.external.TiledExternal;

import picotest.PicoAssert.*;

class ArpThirdpartyFlashComponentsCase {

	public function testFields() {
		assertNotNull(new TiledExternal());
	}

}
#end
