package arpx.camera;

import arp.domain.IArpObject;
import arpx.structs.ArpPosition;

@:arpType("camera", "camera")
class Camera implements IArpObject {
	@:arpField public var position:ArpPosition;

	public function new() {
	}
}
