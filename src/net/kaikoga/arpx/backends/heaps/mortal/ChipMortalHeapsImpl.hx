package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.math.ITransform;
import net.kaikoga.arpx.mortal.ChipMortal;

class ChipMortalHeapsImpl extends ArpObjectImplBase implements IMortalHeapsImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.copyChip(buf, transform, mortal.params);
		}
	}
}

#end
