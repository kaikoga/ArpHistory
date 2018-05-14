package net.kaikoga.arpx.impl.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.decorators.TranslateChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.Transform;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;

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

