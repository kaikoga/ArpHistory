package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.AMatrix;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.decorators.TranslateChip;

class TranslateChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = new AMatrix(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		this.chip.chip.copyChip(g2, aMatrix, params);
	}
}

#end
