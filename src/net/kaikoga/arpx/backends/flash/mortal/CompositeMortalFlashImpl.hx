package net.kaikoga.arpx.backends.flash.mortal;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import flash.display.BitmapData;

import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.mortal.CompositeMortal;
import net.kaikoga.arp.structs.ArpPosition;

class CompositeMortalFlashImpl extends ArpObjectImplBase implements IMortalFlashImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			for (s in mortal.mortals) { // TODO sort mortals
				s.copySelf(bitmapData, transform);
			}
		}
	}

}


