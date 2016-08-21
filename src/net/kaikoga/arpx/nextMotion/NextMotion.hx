package net.kaikoga.arpx.nextMotion;

import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arp.structs.ArpRange;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("nextMotion", "nextMotion"))
class NextMotion implements IArpObject {

	@:arpField public var motion:Motion;
	@:arpField public var action:String;
	@:arpField public var timeRange:ArpRange;

	public function new() {
	}
}


