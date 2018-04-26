package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.decorators.FilterChip;

class FilterChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

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

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		this.chip.chip.copyChip(context, p);
	}
}

#end