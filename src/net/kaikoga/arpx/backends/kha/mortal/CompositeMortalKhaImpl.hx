package net.kaikoga.arpx.backends.kha.mortal;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.field.FieldKhaImpl;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.mortal.CompositeMortal;

class CompositeMortalKhaImpl extends ArpObjectImplBase implements IMortalKhaImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			FieldKhaImpl.copySortedMortals(mortal.mortals, g2, transform);
		}
	}

}

#end
