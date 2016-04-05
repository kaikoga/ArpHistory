package net.kaikoga.arp.macro.mocks;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.buildDerived("mock", "macroDerived"))
class MockMacroDerivedArpObject extends MockMacroArpObject {

	@:arpValue public var intField2:Int = 0;
	@:arpValue public var stringField2:String = null;
	@:arpBarrier @:arpType("mock") public var refField2:MockMacroDerivedArpObject;

	public function new() {
		super();
	}
}
