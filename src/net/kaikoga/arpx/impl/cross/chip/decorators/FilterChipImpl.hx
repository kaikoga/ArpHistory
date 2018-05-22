package net.kaikoga.arpx.impl.cross.chip.decorators;

import net.kaikoga.arpx.chip.decorators.FilterChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.structs.IArpParamsRead;

class FilterChipImpl extends ArpObjectImplBase implements IChipImpl {

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

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		this.chip.chip.render(context, p);
	}
}
