package net.kaikoga.arpx.backends.flash.chip.decorators;

import net.kaikoga.arpx.chip.Chip;
import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.SelectChip;

class SelectChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:SelectChip;

	public function new(chip:SelectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		var chip:Chip = this.chip.chips.get(params.getAsString(this.chip.selector, this.chip.defaultKey));
		if (chip != null) chip.copyChip(bitmapData, transform, params);
	}
}
