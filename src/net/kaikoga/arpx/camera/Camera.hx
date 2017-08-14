package net.kaikoga.arpx.camera;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.field.Field;
import net.kaikoga.arpx.fieldGizmo.FieldGizmo;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.camera.ICameraFlashImpl;
import net.kaikoga.arpx.backends.flash.camera.CameraFlashImpl;
#end

@:arpType("camera", "camera")
class Camera implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements ICameraFlashImpl #end
{
	@:arpField public var visible:Bool = true;
	@:arpField public var position:ArpPosition;
	@:arpField public var field:Field;
	@:arpBarrier @:arpField("fieldGizmo") public var fieldGizmos:IList<FieldGizmo>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CameraFlashImpl;
	#else
	@:arpWithoutBackend
#end
	public function new() {
	}
}
