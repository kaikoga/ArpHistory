package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.math.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(buf:Sprite):Void {
		if (this.screen.visible) {
			var workPt:APoint = _workPt;
			var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
			workPt.x = -pos.x;
			workPt.y = -pos.y;
			for (hud in this.screen.huds) hud.copySelf(buf, workPt);
		}
	}
}

#end
