package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.math.AMatrix;
import net.kaikoga.arpx.backends.heaps.math.ITransform;
import net.kaikoga.arpx.chip.decorators.TranslateChip;

class TranslateChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = new AMatrix(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		this.chip.chip.copyChip(buf, aMatrix, params);
	}
}

#end
