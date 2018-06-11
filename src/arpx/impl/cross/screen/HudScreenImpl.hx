package arpx.impl.cross.screen;

import arpx.display.DisplayContext;
import arpx.impl.ArpObjectImplBase;
import arpx.screen.HudScreen;
import arpx.structs.ArpPosition;

class HudScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (!this.screen.visible) return;

		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		context.dupTransform().setXY(-pos.x, -pos.y);
		for (hud in this.screen.huds) hud.render(context);
		context.popTransform();
	}
}
