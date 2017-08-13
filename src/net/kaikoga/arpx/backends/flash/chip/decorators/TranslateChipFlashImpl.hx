package net.kaikoga.arpx.backends.flash.chip.decorators;

import flash.geom.Matrix;
import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.TranslateChip;

class TranslateChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	private static var workMatrix:Matrix = new Matrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		workMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		var t:ITransform = transform.concatMatrix(workMatrix);
		this.chip.chip.copyChip(bitmapData, t, params);
	}
}
