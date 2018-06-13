package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.CompositeChip;
import arpx.display.DisplayContext;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

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