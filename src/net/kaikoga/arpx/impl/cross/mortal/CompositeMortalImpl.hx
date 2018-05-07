package net.kaikoga.arpx.impl.cross.mortal;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.field.FieldImpl;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.mortal.CompositeMortal;

class CompositeMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function render(context:DisplayContext):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			FieldImpl.copySortedMortals(mortal.mortals, context);
			context.popTransform();
		}
	}

}
