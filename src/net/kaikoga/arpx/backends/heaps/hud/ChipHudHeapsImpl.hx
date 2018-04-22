package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.hud.ChipHud;

class ChipHudHeapsImpl extends ArpObjectImplBase implements IHudHeapsImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(context:DisplayContext):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			// TODO hud.params.dir = pos.dir;
			hud.chip.copyChip(context, hud.params);
			context.popTransform();
		}
	}

}

#end
