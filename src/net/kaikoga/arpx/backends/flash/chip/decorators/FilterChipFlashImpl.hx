package net.kaikoga.arpx.backends.flash.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.decorators.FilterChip;

class FilterChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

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
