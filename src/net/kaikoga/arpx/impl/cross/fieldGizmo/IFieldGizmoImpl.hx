package net.kaikoga.arpx.impl.cross.fieldGizmo;

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoImpl extends IArpObjectImpl {
	function render(field:Field, context:DisplayContext):Void;
}
