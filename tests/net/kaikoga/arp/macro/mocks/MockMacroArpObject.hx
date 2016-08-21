package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("mock", "macro"))
class MockMacroArpObject implements IArpObject {

	@:arpField public var intField:Int = 1000000;
	@:arpField public var floatField:Float = 1000000;
	@:arpField public var boolField:Bool = false;
	@:arpField public var stringField:String = null;

	public var stringField2(get, set):String;
	private function get_stringField2():String return "stringField2";
	private function set_stringField2(value:String):String return value;

	@:arpBarrier @:arpField public var refField:MockMacroArpObject;

	public function new() {
	}
}
