package net.kaikoga.arpx.impl.cross.hud;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.hud.ChipHud;

class ChipHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function render(context:DisplayContext):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			// TODO hud.params.dir = pos.dir;
			hud.chip.render(context, hud.params);
			context.popTransform();
		}
	}

}
