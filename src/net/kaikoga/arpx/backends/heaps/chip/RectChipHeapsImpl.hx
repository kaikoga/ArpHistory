package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Sprite;
import h3d.col.Point;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.math.ITransform;
import net.kaikoga.arpx.chip.RectChip;

class RectChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void {
		//TODO optimize
		var pt:Point = transform.asPoint();
		if (pt != null) {
			/*
			g2.color = chip.border.value32;
			g2.fillRect(pt.x - chip.baseX, pt.y - chip.baseY, chip.chipWidth, chip.chipHeight);
			g2.color = chip.color.value32;
			g2.fillRect(pt.x - chip.baseX + 1, pt.y - chip.baseY + 1, chip.chipWidth - 2, chip.chipHeight - 2);
			g2.color = Color.White;
			*/
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
