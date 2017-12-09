package net.kaikoga.arpx.backends.flash.screen;

import net.kaikoga.arp.structs.ArpPosition;
import flash.display.BitmapData;
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
		var workPt:APoint = _workPt;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		workPt.x = -pos.x;
		workPt.y = -pos.y;
		for (mortal in this.screen.mortals) mortal.copySelf(bitmapData, workPt);
	}
}


