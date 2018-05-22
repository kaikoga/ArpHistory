package net.kaikoga.arpx.nextMotion;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.motion.Motion;
import net.kaikoga.arpx.structs.ArpRange;

@:arpType("nextMotion", "nextMotion")
class NextMotion implements IArpObject {

	@:arpField public var motion:Motion;
	@:arpField public var action:String;
	@:arpField public var timeRange:ArpRange;

	public function new() {
	}
}


