package net.kaikoga.arpx.backends.flash.chip.decorators;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.AMatrix;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.TranslateChip;

class TranslateChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		this.chip.chip.copyChip(bitmapData, aMatrix, params);
	}
}
