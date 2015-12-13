package net.kaikoga.arp.macro.mocks;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.buildDerived("MockMacroArpObject"))
class MockMacroDerivedArpObject extends MockMacroArpObject {

	@:arpValue public var intField2:Int = 0;
	@:arpBarrier @:arpSlot("MockMacroArpObject") public var refField2:MockMacroDerivedArpObject;

	public function new() {
		super();
	}
}
