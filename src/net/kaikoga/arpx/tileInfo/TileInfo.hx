package net.kaikoga.arpx.tileInfo;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpRange;

@:arpType("tileInfo")
class TileInfo implements IArpObject {

	@:arpField public var enterableRange:ArpRange;

	public function new() {
	}

	public function tileZ(tileIndex:Int):Float {
		if (tileIndex == 0) {
			return 0;
		}
		if (this.enterableRange.contains(tileIndex)) {
			return 0;
		}
		return 1;
	}
}
