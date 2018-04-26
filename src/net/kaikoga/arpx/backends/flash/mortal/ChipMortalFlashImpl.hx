package net.kaikoga.arpx.backends.flash.mortal;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.mortal.ChipMortal;

class ChipMortalFlashImpl extends ArpObjectImplBase implements IMortalFlashImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.copyChip(bitmapData, transform, mortal.params);
		}
	}

}

#end
