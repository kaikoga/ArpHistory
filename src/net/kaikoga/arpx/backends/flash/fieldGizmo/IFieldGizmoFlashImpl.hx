package net.kaikoga.arpx.backends.flash.fieldGizmo;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.field.Field;

interface IFieldGizmoFlashImpl extends IArpObjectImpl {

	function render(field:Field, context:DisplayContext):Void;

}

#end
