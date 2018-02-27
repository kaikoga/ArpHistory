package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.decorators.FilterChip;

class FilterChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:FilterChip;

	public function new(chip:FilterChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		return true;
	}

	override public function arpHeatDown():Bool {
		return true;
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		this.chip.chip.copyChip(bitmapData, transform, p);
	}
}

#end
