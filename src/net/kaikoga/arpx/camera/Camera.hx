package net.kaikoga.arpx.camera;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.shadow.IShadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("camera", "camera"))
class Camera implements ICamera
{
	@:arpType("shadow") public var shadow:IShadow;
	@:arpValue public var position:ArpPosition;

	public function new() {
	}

}
