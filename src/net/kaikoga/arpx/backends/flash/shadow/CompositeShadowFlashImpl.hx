package net.kaikoga.arpx.backends.flash.shadow;

import net.kaikoga.arpx.shadow.IShadow;
import flash.display.BitmapData;

import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.shadow.CompositeShadow;
import net.kaikoga.arp.structs.ArpPosition;

class CompositeShadowFlashImpl implements IShadowFlashImpl {

	private var shadow:CompositeShadow;

	public function new(shadow:CompositeShadow) {
		this.shadow = shadow;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (shadow.visible) {
			var pos:ArpPosition = shadow.position;
			transform = transform.concatXY(pos.x, pos.y);
			for (s in shadow.shadows) { // TODO sort shadows
				s.copySelf(bitmapData, transform);
			}
		}
	}

}


