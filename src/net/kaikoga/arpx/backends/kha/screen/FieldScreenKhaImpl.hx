package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.APoint;
import net.kaikoga.arpx.screen.FieldScreen;

class FieldScreenKhaImpl extends ArpObjectImplBase implements IScreenKhaImpl {

	private var screen:FieldScreen;

	public function new(screen:FieldScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(bitmapData:BitmapData):Void {
		if (this.screen.field == null) return;

		var workPt:APoint = _workPt;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		workPt.x = -pos.x;
		workPt.y = -pos.y;
		if (this.screen.visible) {
			this.screen.field.copySelf(bitmapData, workPt);
		}

		for (fieldGizmo in this.screen.fieldGizmos) {
			fieldGizmo.render(this.screen.field, bitmapData, workPt);
		}
	}
}

#end
