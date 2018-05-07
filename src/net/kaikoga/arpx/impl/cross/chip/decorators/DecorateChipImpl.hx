package net.kaikoga.arpx.impl.cross.chip.decorators;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;
import net.kaikoga.arpx.chip.decorators.DecorateChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.AMatrix;

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

	private static var workMatrix:AMatrix = new AMatrix();
	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = workMatrix;
		aMatrix.reset(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix.appendTransform(context.transform);
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		context.pushTransform(aMatrix);
		this.chip.chip.render(context, p);
		context.popTransform();
	}
}

