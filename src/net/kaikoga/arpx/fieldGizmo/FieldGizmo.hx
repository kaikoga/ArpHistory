package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.backends.cross.fieldGizmo.IFieldGizmoImpl;

@:arpType("fieldGizmo")
class FieldGizmo implements IArpObject implements IFieldGizmoImpl {

	@:arpField public var visible:Bool = true;

	@:arpImpl private var arpImpl:IFieldGizmoImpl;

	public function new() return;
}
