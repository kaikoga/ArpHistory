package net.kaikoga.arpx.camera;

import net.kaikoga.arpx.field.Field;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpPosition;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("camera", "camera"))
class Camera implements IArpObject {

	@:arpField public var field:Field;
	@:arpField public var position:ArpPosition;

	public function new() {
	}

}
