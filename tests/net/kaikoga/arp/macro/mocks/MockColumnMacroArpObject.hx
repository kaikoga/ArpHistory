package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockMacroArpObject"))
class MockColumnMacroArpObject implements IArpObject {

	@:arpField @:arpColumn("if") public var intField:Int = 0;
	@:arpField @:arpColumn("ff") public var floatField:Float = 0;
	@:arpField @:arpColumn("bf") public var boolField:Bool = false;
	@:arpField @:arpColumn("sf") public var stringField:String = null;

	@:arpBarrier @:arpSlot("MockMacroArpObject") @:arpColumn("rf") public var refField:MockColumnMacroArpObject;

	public function new() {
	}
}
