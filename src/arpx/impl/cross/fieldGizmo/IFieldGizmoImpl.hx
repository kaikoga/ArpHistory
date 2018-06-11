package arpx.impl.cross.fieldGizmo;

import arp.impl.IArpObjectImpl;
import arpx.display.DisplayContext;
import arpx.field.Field;

interface IFieldGizmoImpl extends IArpObjectImpl {
	function render(field:Field, context:DisplayContext):Void;
}
