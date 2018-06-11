package arpx.impl.cross.hud;

import arpx.display.DisplayContext;
import arpx.hud.ChipHud;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.ArpPosition;

class ChipHudImpl extends ArpObjectImplBase implements IHudImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function render(context:DisplayContext):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			context.dupTransform().appendXY(pos.x, pos.y);
			// TODO hud.params.dir = pos.dir;
			hud.chip.render(context, hud.params);
			context.popTransform();
		}
	}

}
