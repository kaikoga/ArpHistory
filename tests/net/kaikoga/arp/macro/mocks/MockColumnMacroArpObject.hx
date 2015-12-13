package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockMacroArpObject"))
class MockColumnMacroArpObject implements IArpObject {

	@:arpValue @:arpColumn("if") public var intField:Int = 0;
	@:arpValue @:arpColumn("ff") public var floatField:Float = 0;
	@:arpValue @:arpColumn("bf") public var boolField:Bool = false;
	@:arpValue @:arpColumn("sf") public var stringField:String = null;

	@:arpBarrier @:arpType("MockMacroArpObject") @:arpColumn("rf") public var refField:MockColumnMacroArpObject;

	public function new() {
	}
}
