package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.AMatrix;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.decorators.DecorateChip;

class DecorateChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:DecorateChip;

	public function new(chip:DecorateChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		return true;
	}

	override public function arpHeatDown():Bool {
		return true;
	}

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		this.chip.chip.copyChip(bitmapData, aMatrix, p);
	}
}

#end
