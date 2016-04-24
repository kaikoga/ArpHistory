package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock", "earlyPrepare"))
class MockEarlyPrepareMacroArpObject implements IArpObject {

	public var volatileInt:Int = 0;

	public function new() {
	}

	public function heatUp():Bool {
		this.volatileInt = 1;
		return true;
	}

	public function heatDown():Bool {
		this.volatileInt = 0;
		return true;
	}

}
