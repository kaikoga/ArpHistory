package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockStdDsMacroArpObject"))
class MockStdDsMacroArpObject implements IArpObject {

	@:arpValue public var intStdArray:Array<Int>;
	@:arpValue public var intStdList:List<Int>;
	@:arpValue public var intStdMap:Map<String, Int>;
	@:arpValue public var floatStdArray:Array<Float>;
	@:arpValue public var floatStdList:List<Float>;
	@:arpValue public var floatStdMap:Map<String, Float>;
	@:arpValue public var boolStdArray:Array<Bool>;
	@:arpValue public var boolStdList:List<Bool>;
	@:arpValue public var boolStdMap:Map<String, Bool>;
	@:arpValue public var stringStdArray:Array<String>;
	@:arpValue public var stringStdList:List<String>;
	@:arpValue public var stringStdMap:Map<String, String>;

	//@:arpSlot("MockMacroArpObject") public var refStdArray:Array<MockMacroArpObject>;
	//@:arpSlot("MockMacroArpObject") public var refStdList:List<MockMacroArpObject>;
	@:arpSlot("MockStdDsMacroArpObject") public var refStdMap:Map<String, MockStdDsMacroArpObject>;

	public function new() {
	}
}
