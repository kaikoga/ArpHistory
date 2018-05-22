package net.kaikoga.arpx.impl.cross.mortal;

import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.mortal.ChipMortal;
import net.kaikoga.arpx.structs.ArpPosition;

class ChipMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function render(context:DisplayContext):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			context.dupTransform().appendXY(pos.x, pos.y);
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.render(context, mortal.params);
			context.popTransform();
		}
	}
}
