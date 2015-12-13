package net.kaikoga.arp.macro.mocks;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.buildDerived("mock"))
class MockMacroDerivedArpObject extends MockMacroArpObject {

	@:arpValue public var intField2:Int = 0;
	@:arpBarrier @:arpType("mock") public var refField2:MockMacroDerivedArpObject;

	public function new() {
		super();
	}
}
