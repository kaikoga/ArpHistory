package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.heaps.geom.AMatrix;
import net.kaikoga.arpx.chip.decorators.TranslateChip;

class TranslateChipHeapsImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TranslateChip;

	public function new(chip:TranslateChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = new AMatrix(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix.appendTransform(context.transform);
		context.pushTransform(aMatrix);
		this.chip.chip.copyChip(context, params);
		context.popTransform();
	}
}

#end
