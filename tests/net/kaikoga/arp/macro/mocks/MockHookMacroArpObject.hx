package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("MockMacroArpObject"))
class MockHookMacroArpObject implements IArpObject {

	public var volatileInt:Int = 0;

	@:arpSlot("MockMacroArpObject") public var refField:MockHookMacroArpObject;

	public function new() {
	}

	public function init(slot:ArpUntypedSlot, seed:ArpSeed = null):IArpObject {
		this.volatileInt = 1;
	}

	public function dispose():Void {
		this.volatileInt = 0;
	}

}
