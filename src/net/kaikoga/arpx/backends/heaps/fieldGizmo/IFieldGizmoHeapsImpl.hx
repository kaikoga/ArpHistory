package net.kaikoga.arpx.backends.heaps.fieldGizmo;

#if arp_backend_heaps

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoHeapsImpl extends IArpObjectImpl {
	function render(field:Field, context:DisplayContext):Void;
}

#end
