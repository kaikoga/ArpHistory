package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import kha.graphics2.Graphics;

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

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var chip:Chip = this.chip.chips.get(params.getAsString(this.chip.selector, this.chip.defaultKey));
		if (chip != null) chip.copyChip(g2, transform, params);
	}
}

#end
