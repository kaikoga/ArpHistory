package net.kaikoga.arpx.backends.flash.camera;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arpx.camera.Camera;

class CameraFlashImpl extends ArpObjectImplBase implements ICameraFlashImpl {

	private var camera:Camera;

	public function new(camera:Camera) {
		super();
		this.camera = camera;
	}

	private static var _workPt:APoint = new APoint();

	public function display(bitmapData:BitmapData):Void {
		var workPt:APoint = _workPt;
		var pos:ArpPosition = this.camera.position;
		workPt.x = -pos.x;
		workPt.y = -pos.y;
		if (this.camera.visible) {
			this.camera.field.copySelf(bitmapData, workPt);
		}

		for (fieldGizmo in this.camera.fieldGizmos) {
			fieldGizmo.render(this.camera.field, bitmapData, workPt);
		}
	}
}


