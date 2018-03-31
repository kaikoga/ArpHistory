package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.decorators.CompositeChip;

class CompositeChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:CompositeChip;

	public function new(chip:CompositeChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		for (c in this.chip.chips) c.copyChip(g2, transform, params);
	}
}

#end
