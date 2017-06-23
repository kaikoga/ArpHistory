package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.structs.ArpHitCuboid;
import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.structs.ArpRange;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("mock", "structMacro")
class MockStructMacroArpObject implements IArpObject {

	@:arpField public var arpColorField:ArpColor;
	@:arpField public var arpDirectionField:ArpDirection;
	@:arpField public var arpHitCuboidField:ArpHitCuboid;
	@:arpField public var arpParamsField:ArpParams;
	@:arpField public var arpPositionField:ArpPosition;
	@:arpField public var arpRangeField:ArpRange;

	public function new() {
	}
}
