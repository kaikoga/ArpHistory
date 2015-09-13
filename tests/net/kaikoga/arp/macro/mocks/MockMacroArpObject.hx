package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.ArpObjectBuilder.build("MockMacroArpObject"))
class MockMacroArpObject implements IArpObject {

	public var intField:Int = 0;
	@:arpSlot("MockMacroArpObject") public var refField:MockMacroArpObject;

	public function new() {
	}
}
