package net.kaikoga.arpx.backends.flash.shadow;

import flash.display.BitmapData;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.shadow.ChipShadow;

class ChipShadowFlashImpl implements IShadowFlashImpl {

	private var shadow:ChipShadow;

	public function new(shadow:ChipShadow) {
		this.shadow = shadow;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (shadow.visible && shadow.chip != null) {
			var pos:ArpPosition = shadow.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO shadow.params.dir = pos.dir;
			shadow.chip.copyChip(bitmapData, transform, shadow.params);
		}
	}

}


