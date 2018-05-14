package net.kaikoga.arpx.impl.cross.screen;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.Transform;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.screen.HudScreen;

class HudScreenImpl extends ArpObjectImplBase implements IScreenImpl {

	private var screen:HudScreen;

	public function new(screen:HudScreen) {
		super();
		this.screen = screen;
	}

	private static var _workTransform:Transform = new Transform();
	private static var _workPos:ArpPosition = new ArpPosition();

	public function display(context:DisplayContext):Void {
		if (!this.screen.visible) return;

		var transform:Transform = _workTransform;
		var pos:ArpPosition = (this.screen.camera != null) ? this.screen.camera.position : _workPos;
		transform.setXY(-pos.x, -pos.y);
		context.pushTransform(transform);
		for (hud in this.screen.huds) hud.render(context);
		context.popTransform();
	}
}
