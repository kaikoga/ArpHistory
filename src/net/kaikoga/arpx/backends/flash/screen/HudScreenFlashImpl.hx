package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenFlashImpl extends ArpObjectImplBase implements IScreenFlashImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(bitmapData:BitmapData):Void {
		if (this.screen.visible) {
			var workPt:APoint = _workPt;
			var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
			workPt.x = -pos.x;
			workPt.y = -pos.y;
			for (hud in this.screen.huds) hud.copySelf(bitmapData, workPt);
		}
	}
}

#end
