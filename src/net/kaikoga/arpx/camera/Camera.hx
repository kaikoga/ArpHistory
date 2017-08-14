package net.kaikoga.arpx.camera;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.fieldGizmo.FieldGizmo;

@:arpType("camera", "camera")
class Camera implements IArpObject {

	@:arpField public var position:ArpPosition;
	@:arpField public var field:Field;
	@:arpBarrier @:arpField("fieldGizmo") public var fieldGizmos:IList<FieldGizmo>;

	public function new() {
	}

}
