package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockMacroArpObject"))
class MockColumnMacroArpObject implements IArpObject {

	@:arpValue @:arpField("if") public var intField:Int = 0;
	@:arpValue @:arpField("ff") public var floatField:Float = 0;
	@:arpValue @:arpField("bf") public var boolField:Bool = false;
	@:arpValue @:arpField("sf") public var stringField:String = null;

	@:arpBarrier @:arpType("MockMacroArpObject") @:arpField("rf") public var refField:MockColumnMacroArpObject;

	public function new() {
	}
}
