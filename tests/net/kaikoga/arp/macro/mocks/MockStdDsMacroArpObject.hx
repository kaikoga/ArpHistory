package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockStdDsMacroArpObject"))
class MockStdDsMacroArpObject implements IArpObject {

	@:arpField public var intStdArray:Array<Int>;
	@:arpField public var intStdList:List<Int>;
	@:arpField public var intStdMap:Map<String, Int>;
	@:arpField public var floatStdArray:Array<Float>;
	@:arpField public var floatStdList:List<Float>;
	@:arpField public var floatStdMap:Map<String, Float>;
	@:arpField public var boolStdArray:Array<Bool>;
	@:arpField public var boolStdList:List<Bool>;
	@:arpField public var boolStdMap:Map<String, Bool>;
	@:arpField public var stringStdArray:Array<String>;
	@:arpField public var stringStdList:List<String>;
	@:arpField public var stringStdMap:Map<String, String>;

	//@:arpSlot("MockMacroArpObject") public var refStdArray:Array<MockMacroArpObject>;
	//@:arpSlot("MockMacroArpObject") public var refStdList:List<MockMacroArpObject>;
	//@:arpSlot("MockMacroArpObject") public var refStdMap:Map<MockMacroArpObject>;

	public function new() {
	}
}
