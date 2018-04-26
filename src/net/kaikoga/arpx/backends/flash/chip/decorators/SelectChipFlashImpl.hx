package net.kaikoga.arpx.backends.flash.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.chip.decorators.SelectChip;

class SelectChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

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
