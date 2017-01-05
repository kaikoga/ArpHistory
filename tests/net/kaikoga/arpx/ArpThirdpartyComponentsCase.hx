package net.kaikoga.arpx;

import net.kaikoga.arpx.external.TiledExternal;
import net.kaikoga.arpx.tileMap.FmfFileTileMap;

import picotest.PicoAssert.*;

class ArpThirdpartyComponentsCase {

	public function testFields() {
		assertNotNull(new TiledExternal());

		assertNotNull(new FmfFileTileMap());
	}

}
