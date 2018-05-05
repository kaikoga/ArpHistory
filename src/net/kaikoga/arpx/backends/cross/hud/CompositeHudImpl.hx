package net.kaikoga.arpx.backends.cross.hud;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.hud.CompositeHud;

class CompositeHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:CompositeHud;

	public function new(hud:CompositeHud) {
		super();
		this.hud = hud;
	}

	public function render(context:DisplayContext):Void {
		if (hud.visible) {
			var pos:ArpPosition = hud.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			for (h in hud.huds) h.render(context);
			context.popTransform();
		}
	}
}