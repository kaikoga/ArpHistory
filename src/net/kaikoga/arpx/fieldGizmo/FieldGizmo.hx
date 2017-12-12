package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.fieldGizmo.IFieldGizmoFlashImpl;
#end

@:arpType("fieldGizmo")
class FieldGizmo implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IFieldGizmoFlashImpl #end
{
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFieldGizmoFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
	}

}
