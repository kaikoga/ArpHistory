package net.kaikoga.arpx.camera;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.shadow.Shadow;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("camera", "camera"))
class Camera implements IArpObject {
	@:arpType("shadow") public var shadow:Shadow;
	@:arpValue public var position:ArpPosition;

	public function new() {
	}

}
