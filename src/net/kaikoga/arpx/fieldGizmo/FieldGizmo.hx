package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.fieldGizmo.IFieldGizmoFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.fieldGizmo.IFieldGizmoKhaImpl;
#end

@:arpType("fieldGizmo")
class FieldGizmo implements IArpObject
	#if (arp_backend_flash || arp_backend_openfl) implements IFieldGizmoFlashImpl #end
	#if (arp_backend_flash || arp_backend_openfl) implements IFieldGizmoKhaImpl #end
{
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFieldGizmoFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:IFieldGizmoKhaImpl;
	#end

	public function new() return;
}
