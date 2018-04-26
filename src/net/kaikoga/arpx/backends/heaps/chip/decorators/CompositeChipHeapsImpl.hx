package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.decorators.CompositeChip;

class CompositeChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

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