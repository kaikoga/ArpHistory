package net.kaikoga.arpx.camera;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.structs.ArpPosition;

@:arpType("camera", "camera")
class Camera implements IArpObject {
	@:arpField public var position:ArpPosition;

	public function new() {
	}
}
