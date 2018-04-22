package net.kaikoga.arpx.backends.heaps.screen;

#if arp_backend_heaps

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.heaps.geom.APoint;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenHeapsImpl extends ArpObjectImplBase implements IScreenHeapsImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (this.screen.visible) {
			var workPt:APoint = _workPt;
			var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
			workPt.x = -pos.x;
			workPt.y = -pos.y;
			context.pushTransform(workPt);
			for (hud in this.screen.huds) hud.copySelf(context);
			context.popTransform();
		}
	}
}

#end
