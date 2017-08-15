package net.kaikoga.arpx.backends.flash.chip.decorators;

import flash.display.BitmapData;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.decorators.FilterChip;

class FilterChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:FilterChip;
	private var workParams:ArpParams;

	public function new(chip:FilterChip) {
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
		if (this.chip.paramsOp != null) {
			params = this.chip.paramsOp.filter(params, this.workParams);
		}
		this.chip.chip.copyChip(bitmapData, transform, params);
	}
}
