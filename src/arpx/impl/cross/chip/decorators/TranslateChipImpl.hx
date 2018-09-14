package arpx.impl.cross.chip.decorators;

import arpx.chip.decorators.TranslateChip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.geom.ArpTransform;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.IArpParamsRead;

class TranslateChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	private static var _workTransform:ArpTransform = new ArpTransform();
	public function render(context:RenderContext, params:IArpParamsRead = null):Void {
		context.dupTransform().prependTransform(_workTransform.reset(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y));
		this.chip.chip.render(context, params);
		context.popTransform();
	}
}

