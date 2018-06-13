package arpx.impl.cross.chip.decorators;

import arpx.chip.Chip;
import arpx.chip.decorators.SelectChip;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

class SelectChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:SelectChip;

	public function new(chip:SelectChip) {
		super();
		this.chip = chip;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var chip:Chip = this.chip.chips.get(params.getAsString(this.chip.selector, this.chip.defaultKey));
		if (chip != null) chip.render(context, params);
	}
}
