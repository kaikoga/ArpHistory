package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.structs.ArpHitArea;
import net.kaikoga.arp.structs.ArpColor;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.structs.ArpRange;
import net.kaikoga.arp.structs.ArpArea2d;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock", "structMacro"))
class MockStructMacroArpObject implements IArpObject {

	@:arpValue public var arpArea2dField:ArpArea2d;
	@:arpValue public var arpColorField:ArpColor;
	@:arpValue public var arpDirectionField:ArpDirection;
	@:arpValue public var arpHitAreaField:ArpHitArea;
	@:arpValue public var arpParamsField:ArpParams;
	@:arpValue public var arpPositionField:ArpPosition;
	@:arpValue public var arpRangeField:ArpRange;

	public function new() {
	}
}
