package net.kaikoga.arpx.backends.flash.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.backends.flash.geom.AMatrix;
import net.kaikoga.arpx.chip.decorators.DecorateChip;

class DecorateChipFlashImpl extends ArpObjectImplBase implements IChipImpl {

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

	private static var workMatrix:AMatrix = new AMatrix();
	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.setTo(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix.appendTransform(context.transform);
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
