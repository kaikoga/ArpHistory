package net.kaikoga.arpx.backends.heaps.chip.decorators;

#if arp_backend_heaps

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.heaps.geom.AMatrix;
import net.kaikoga.arpx.chip.decorators.DecorateChip;

class DecorateChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

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

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = new AMatrix(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(context.transform);
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		context.pushTransform(aMatrix);
		this.chip.chip.copyChip(context, p);
		context.popTransform();
	}
}

#end
