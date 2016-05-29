package net.kaikoga.arpx.hitFrame;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpPosition;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("hitFrame", "null"))
class HitFrame implements IArpObject {

	public function new() {
	}

	public function collidesPosition(base:ArpPosition, position:ArpPosition):Bool {
		return false;
	}

	public function collidesCoordinate(base:ArpPosition, x:Float, y:Float, z:Float):Bool {
		return false;
	}

	public function collidesHitFrame(base:ArpPosition, targetBase:ArpPosition, target:HitFrame):Bool {
		return false;
	}

	public function mapTo(base:ArpPosition, targetBase:ArpPosition, target:HitFrame, input:ArpPosition, output:ArpPosition = null):ArpPosition {
		if (output != null) return output;
		return input.clone();
	}
}


