package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.ArpObjectBuilder.build("MockMacroArpObject"))
class MockMacroArpObject implements IArpObject {

	@:arpField public var intField:Int = 0;
	@:arpField public var floatField:Float = 0;
	@:arpField public var boolField:Bool = false;
	@:arpField public var stringField:String = null;

	@:arpSlot("MockMacroArpObject") public var refField:MockMacroArpObject;

	public function new() {
	}
}
