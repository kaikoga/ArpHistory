package net.kaikoga.arpx.backends.cross.fieldGizmo;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoImpl extends IArpObjectImpl {
	function render(field:Field, context:DisplayContext):Void;
}
