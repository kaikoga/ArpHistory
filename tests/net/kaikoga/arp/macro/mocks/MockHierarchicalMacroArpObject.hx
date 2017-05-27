package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("mock", "reference"))
class MockHierarchicalMacroArpObject implements IArpObject {

	@:arpField public var refField:MockHierarchicalMacroArpObject;
	@:arpField @:arpDefault("default") public var defaultRefField:MockHierarchicalMacroArpObject;
	@:arpField @:arpDefault("bogus") public var bogusRefField:MockHierarchicalMacroArpObject;

	public function new() {
	}
}
