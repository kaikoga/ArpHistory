package arpx.impl.cross.mortal;

import arpx.display.DisplayContext;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.field.FieldImpl;
import arpx.mortal.CompositeMortal;
import arpx.structs.ArpPosition;

class CompositeMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:CompositeMortal;

	public function new(mortal:CompositeMortal) {
		super();
		this.mortal = mortal;
	}

	public function render(context:DisplayContext):Void {
		if (mortal.visible) {
			var pos:ArpPosition = mortal.position;
			context.dupTransform().appendXY(pos.x, pos.y);
			FieldImpl.copySortedMortals(mortal.mortals, context);
			context.popTransform();
		}
	}

}
