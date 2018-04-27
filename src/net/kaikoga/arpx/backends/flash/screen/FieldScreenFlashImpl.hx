package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arpx.screen.FieldScreen;

class FieldScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:FieldScreen;

	public function new(screen:FieldScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (this.screen.field == null) return;

		var workPt:APoint = _workPt;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		workPt.x = -pos.x;
		workPt.y = -pos.y;
		context.pushTransform(workPt);
		if (this.screen.visible) {
			this.screen.field.render(context);
		}

		for (fieldGizmo in this.screen.fieldGizmos) {
			fieldGizmo.render(this.screen.field, context);
		}
		context.popTransform();
	}
}

#end
