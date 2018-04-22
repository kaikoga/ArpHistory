package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import net.kaikoga.arpx.backends.heaps.display.DisplayContext;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.field.FieldHeapsImpl;
import net.kaikoga.arpx.mortal.CompositeMortal;

class CompositeMortalHeapsImpl extends ArpObjectImplBase implements IMortalHeapsImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(context:DisplayContext):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			FieldHeapsImpl.copySortedMortals(mortal.mortals, context);
			context.popTransform();
		}
	}

}

#end
