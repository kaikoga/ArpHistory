package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.Color;
import kha.math.Vector2;
import kha.graphics2.Graphics;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.RectChip;

class RectChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		//TODO optimize
		var pt:Vector2 = transform.asPoint();
		if (pt != null) {
			g2.color = chip.border.value32;
			g2.fillRect(pt.x - chip.baseX, pt.y - chip.baseY, chip.chipWidth, chip.chipHeight);
			g2.color = chip.color.value32;
			g2.fillRect(pt.x - chip.baseX + 1, pt.y - chip.baseY + 1, chip.chipWidth - 2, chip.chipHeight - 2);
			g2.color = Color.White;
		} else {
			/*
			var workMatrix:Matrix = _workMatrix;
			workMatrix.setTo(1, 0, 0, 1, -this.baseX, -this.baseY);
			workMatrix.concat(transform.toMatrix());
			bitmapData.draw(this.exportChipSprite(params), workMatrix, transform.colorTransform, transform.blendMode);
			*/
		}
	}
}

#end
