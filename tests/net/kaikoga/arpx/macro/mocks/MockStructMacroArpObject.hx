package net.kaikoga.arpx.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.structs.ArpColor;
import net.kaikoga.arpx.structs.ArpDirection;
import net.kaikoga.arpx.structs.ArpHitCuboid;
import net.kaikoga.arpx.structs.ArpParams;
import net.kaikoga.arpx.structs.ArpPosition;
import net.kaikoga.arpx.structs.ArpRange;

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
