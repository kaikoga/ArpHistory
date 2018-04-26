package net.kaikoga.arpx.backends.flash.mortal;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.field.FieldFlashImpl;
import net.kaikoga.arpx.mortal.CompositeMortal;

class CompositeMortalFlashImpl extends ArpObjectImplBase implements IMortalFlashImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function copySelf(context:DisplayContext):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			FieldFlashImpl.copySortedMortals(mortal.mortals, context);
			context.popTransform();
		}
	}

}

#end
