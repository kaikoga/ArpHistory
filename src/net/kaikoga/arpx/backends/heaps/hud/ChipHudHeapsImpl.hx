package net.kaikoga.arpx.backends.heaps.hud;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.hud.ChipHud;

class ChipHudHeapsImpl extends ArpObjectImplBase implements IHudHeapsImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO hud.params.dir = pos.dir;
			hud.chip.copyChip(buf, transform, hud.params);
		}
	}

}

#end
