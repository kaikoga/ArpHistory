package net.kaikoga.arpx.tileInfo;

import net.kaikoga.arp.structs.ArpRange;

@:build(net.kaikoga.arp.ArpDomainMacros.build("tileInfo", "tileInfo"))
class TileInfo extends IArpObject {

	@:arpValue public var enterableRange:ArpRange;

	public function new() {
		super();
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
