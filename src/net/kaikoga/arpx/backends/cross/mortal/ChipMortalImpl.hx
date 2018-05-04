package net.kaikoga.arpx.backends.cross.mortal;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.mortal.ChipMortal;

class ChipMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:ChipMortal;

	public function new(mortal:ChipMortal) {
		super();
		this.mortal = mortal;
	}

	public function render(context:DisplayContext):Void {
		if (mortal.visible && mortal.chip != null) {
			var pos:ArpPosition = mortal.position;
			context.pushTransform(context.transform.concatXY(pos.x, pos.y));
			// TODO mortal.params.dir = pos.dir;
			mortal.chip.render(context, mortal.params);
			context.popTransform();
		}
	}
}
