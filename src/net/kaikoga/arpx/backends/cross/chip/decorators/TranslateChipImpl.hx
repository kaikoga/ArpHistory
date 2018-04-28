package net.kaikoga.arpx.backends.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.chip.decorators.TranslateChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.AMatrix;

class TranslateChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.reset(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix.appendTransform(context.transform);
		context.pushTransform(aMatrix);
		this.chip.chip.copyChip(context, params);
		context.popTransform();
	}
}

