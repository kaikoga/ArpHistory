package net.kaikoga.arpx.backends.flash.hud;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.hud.ChipHud;

class ChipHudFlashImpl extends ArpObjectImplBase implements IHudFlashImpl {

	private var hud:ChipHud;

	public function new(hud:ChipHud) {
		super();
		this.hud = hud;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (hud.visible && hud.chip != null) {
			var pos:ArpPosition = hud.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO hud.params.dir = pos.dir;
			hud.chip.copyChip(bitmapData, transform, hud.params);
		}
	}

}

#end
