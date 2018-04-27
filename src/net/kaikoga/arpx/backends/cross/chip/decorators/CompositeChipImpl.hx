package net.kaikoga.arpx.backends.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.decorators.CompositeChip;
import net.kaikoga.arpx.display.DisplayContext;

class CompositeChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:CompositeChip;

	public function new(chip:CompositeChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		for (c in this.chip.chips) c.copyChip(context, params);
	}
}
