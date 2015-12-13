package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock"))
class MockHookMacroArpObject implements IArpObject {

	public var volatileInt:Int = 0;

	@:arpType("mock") public var refField:MockHookMacroArpObject;

	public function new() {
	}

	public function init():Void {
		this.volatileInt = 1;
	}

	public function dispose():Void {
		this.volatileInt = 0;
	}

}
