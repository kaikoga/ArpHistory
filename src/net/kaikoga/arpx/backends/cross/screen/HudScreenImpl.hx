package net.kaikoga.arpx.backends.cross.screen;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (!this.screen.visible) return;

		var workPt:APoint = _workPt;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		workPt.setXY(-pos.x, -pos.y);
		context.pushTransform(workPt);
		for (hud in this.screen.huds) hud.render(context);
		context.popTransform();
	}
}
