package net.kaikoga.arpx;

import net.kaikoga.arpx.tileMap.FmfFileTileMap;

import picotest.PicoAssert.*;

class ArpThirdpartyComponentsCase {

	public function testFields() {
		assertNotNull(new FmfFileTileMap());
	}

}
