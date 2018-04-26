package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenKhaImpl extends ArpObjectImplBase implements IScreenKhaImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(g2:Graphics):Void {
		if (this.screen.visible) {
			var workPt:APoint = _workPt;
			var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
			workPt.x = -pos.x;
			workPt.y = -pos.y;
			for (hud in this.screen.huds) hud.copySelf(g2, workPt);
		}
	}
}

#end