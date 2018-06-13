package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.DecorateChip;
import arpx.display.DisplayContext;
import arpx.geom.Transform;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class DecorateChipImpl extends ArpObjectImplBase implements IChipImpl {

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

	private static var _workTransform:Transform = new Transform();
	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		context.dupTransform().appendTransform(_workTransform.reset(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y));
		this.chip.chip.render(context, p);
		context.popTransform();
	}
}
