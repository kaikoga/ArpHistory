package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import flash.display.BitmapData;
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

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		this.chip.chip.copyChip(bitmapData, aMatrix, params);
	}
}

#end
