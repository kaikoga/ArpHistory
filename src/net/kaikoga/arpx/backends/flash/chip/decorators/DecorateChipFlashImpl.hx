package net.kaikoga.arpx.backends.flash.chip.decorators;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.AMatrix;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.DecorateChip;

class DecorateChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:DecorateChip;
	private var workParams:ArpParams;

	public function new(chip:DecorateChip) {
		super();
		this.chip = chip;
		this.workParams = new ArpParams();
	}

	override public function arpHeatUp():Bool {
		return true;
	}

	override public function arpHeatDown():Bool {
		return true;
	}

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		if (this.chip.paramsOp != null) {
			params = this.chip.paramsOp.filter(params, this.workParams);
		}
		this.chip.chip.copyChip(bitmapData, aMatrix, params);
	}
}
