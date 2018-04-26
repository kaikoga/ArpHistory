package net.kaikoga.arpx.backends.flash.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.chip.decorators.CompositeChip;

class CompositeChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:CompositeChip;

	public function new(chip:CompositeChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		for (c in this.chip.chips) c.copyChip(context, params);
	}
}

#end
