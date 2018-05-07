package net.kaikoga.arpx.impl.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.chip.decorators.CompositeChip;
import net.kaikoga.arpx.display.DisplayContext;

class CompositeChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:CompositeChip;

	public function new(chip:CompositeChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		for (c in this.chip.chips) c.render(context, params);
	}
}
