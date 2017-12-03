package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.fieldGizmo.FieldGizmo;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.field.Field;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.FieldScreenFlashImpl;
#end

@:arpType("screen", "screen")
class FieldScreen extends Screen {
	@:arpField public var field:Field;
	@:arpBarrier @:arpField("fieldGizmo") public var fieldGizmos:IList<FieldGizmo>;
	@:arpField public var camera:Camera;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FieldScreenFlashImpl;
	#else
	@:arpWithoutBackend
	#end
	public function new() {
		super();
	}

	override public function tick(timeslice:Float):Bool {
		if (ticks) field.tick(timeslice);
		return true;
	}
}
