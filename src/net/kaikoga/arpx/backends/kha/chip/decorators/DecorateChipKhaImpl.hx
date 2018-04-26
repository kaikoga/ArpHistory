package net.kaikoga.arpx.backends.kha.chip.decorators;

#if arp_backend_kha

import kha.graphics2.Graphics;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.AMatrix;
import net.kaikoga.arpx.chip.decorators.DecorateChip;
import net.kaikoga.arpx.geom.ITransform;

class DecorateChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

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

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var aMatrix:AMatrix = new AMatrix(chip.a, chip.b, chip.c, chip.d, chip.x, chip.y);
		aMatrix._concatTransform(transform);
		var p:IArpParamsRead = params;
		if (this.chip.paramsOp != null) {
			p = this.chip.paramsOp.filter(p);
		}
		this.chip.chip.copyChip(g2, aMatrix, p);
	}
}

#end
