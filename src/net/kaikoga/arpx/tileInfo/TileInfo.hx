package net.kaikoga.arpx.tileInfo;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpRange;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("tileInfo", "tileInfo"))
class TileInfo implements IArpObject {

	@:arpField public var enterableRange:ArpRange;

	public function new() {
	}

	public function tileWeight(tileIndex:Int):Int {
		if (tileIndex == 0) {
			return 0;
		}
		if (this.enterableRange.contains(tileIndex)) {
			return 0;
		}
		return 1;
	}
}
