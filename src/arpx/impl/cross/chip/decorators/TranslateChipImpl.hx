package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TranslateChip;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class TranslateChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	private static var _workTransform:Transform = new Transform();
	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		context.dupTransform().appendTransform(_workTransform.reset(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y));
		this.chip.chip.render(context, params);
		context.popTransform();
	}
}

