package net.kaikoga.arpx.backends.flash.chip.decorators;

import net.kaikoga.arpx.chip.decorators.DecorateChip;
import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

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

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		this.chip.chip.copyChip(bitmapData, transform, this.chip.paramsOp.filter(params, this.workParams));
	}
}
