package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock"))
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

	//@:arpType("mock") public var refStdArray:Array<MockStdDsMacroArpObject>;
	//@:arpType("mock") public var refStdList:List<MockStdDsMacroArpObject>;
	@:arpType("mock") public var refStdMap:Map<String, MockStdDsMacroArpObject>;

	public function new() {
	}
}
