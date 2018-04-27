package net.kaikoga.arpx.fieldGizmo;

import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.fieldGizmo.IFieldGizmoFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.fieldGizmo.IFieldGizmoHeapsImpl;
#end

@:arpType("fieldGizmo")
class FieldGizmo implements IArpObject
	#if (arp_backend_flash || arp_backend_openfl) implements IFieldGizmoFlashImpl
	#elseif arp_backend_heaps implements IFieldGizmoHeapsImpl
	#end
{
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IFieldGizmoFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:IFieldGizmoHeapsImpl;
	#end

	public function new() return;
}
