package net.kaikoga.arpx.backends.kha.hud;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.hud.ChipHud;

class ChipHudKhaImpl extends ArpObjectImplBase implements IHudKhaImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO hud.params.dir = pos.dir;
			hud.chip.copyChip(g2, transform, hud.params);
		}
	}

}

#end
