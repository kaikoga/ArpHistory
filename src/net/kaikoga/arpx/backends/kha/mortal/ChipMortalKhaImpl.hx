package net.kaikoga.arpx.backends.kha.mortal;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.mortal.ChipMortal;

class ChipMortalKhaImpl extends ArpObjectImplBase implements IMortalKhaImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.copyChip(g2, transform, mortal.params);
		}
	}
}

#end
