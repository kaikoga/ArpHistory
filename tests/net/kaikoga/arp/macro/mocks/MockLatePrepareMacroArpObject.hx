package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.IArpObject;

import picotest.PicoTestAsync.*;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock", "latePrepare"))
class MockLatePrepareMacroArpObject implements IArpObject {

	public var volatileInt:Int = 0;
	private var heat:Bool;

	@:arpType("mock") public var refField:MockLatePrepareMacroArpObject;

	public function new() {
	}

	public function heatUp():Bool {
		if (!this.heat) {
			this.arpDomain().waitFor(this);
			this.heat = true;
			createCallback(
				function():Void return,
				1000,
				function():Void {
					this.volatileInt = 1;
					this.arpDomain().notifyFor(this);
				}
			);
		}
		return true;
	}

	public function heatDown():Bool {
		this.volatileInt = 0;
		this.heat = false;
		return true;
	}

}
