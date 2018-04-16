package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.field.FieldHeapsImpl;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.mortal.CompositeMortal;

class CompositeMortalHeapsImpl extends ArpObjectImplBase implements IMortalHeapsImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			transform = transform.concatXY(pos.x, pos.y);
			FieldHeapsImpl.copySortedMortals(mortal.mortals, buf, transform);
		}
	}

}

#end
