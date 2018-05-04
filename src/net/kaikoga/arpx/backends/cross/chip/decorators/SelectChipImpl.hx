package net.kaikoga.arpx.backends.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.chip.decorators.SelectChip;
import net.kaikoga.arpx.display.DisplayContext;

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
