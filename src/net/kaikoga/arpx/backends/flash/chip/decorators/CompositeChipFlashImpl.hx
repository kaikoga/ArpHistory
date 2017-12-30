package net.kaikoga.arpx.backends.flash.chip.decorators;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.CompositeChip;

class CompositeChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:CompositeChip;

	public function new(chip:CompositeChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		for (c in this.chip.chips) c.copyChip(bitmapData, transform, params);
	}
}
