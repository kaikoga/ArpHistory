package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.chip.decorators.SelectChip;

class SelectChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:SelectChip;

	public function new(chip:SelectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var chip:Chip = this.chip.chips.get(params.getAsString(this.chip.selector, this.chip.defaultKey));
		if (chip != null) chip.copyChip(context, params);
	}
}

#end
