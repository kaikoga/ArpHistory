package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.chip.decorators.SelectChip;

class SelectChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:SelectChip;

	public function new(chip:SelectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var chip:Chip = this.chip.chips.get(params.getAsString(this.chip.selector, this.chip.defaultKey));
		if (chip != null) chip.copyChip(bitmapData, transform, params);
	}
}

#end
