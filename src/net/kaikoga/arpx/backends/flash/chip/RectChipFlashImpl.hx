package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.chip.RectChip;

class RectChipFlashImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		//TODO optimize
		var pt:Point = context.transform.asPoint();
		if (pt != null) {
			var workRect:Rectangle = _workRect;
			workRect.setTo(pt.x - chip.baseX, pt.y - chip.baseY, chip.chipWidth, chip.chipHeight);
			context.bitmapData.fillRect(workRect, chip.border.value32);
			workRect.inflate(-1, -1);
			context.bitmapData.fillRect(workRect, chip.color.value32);
		} else {
			/*
			var workMatrix:Matrix = _workMatrix;
			workMatrix.setTo(1, 0, 0, 1, -this.baseX, -this.baseY);
			workMatrix.concat(transform.toMatrix());
			bitmapData.draw(this.exportChipSprite(params), workMatrix, transform.colorTransform, transform.blendMode);
			*/
		}
	}

	/*
	public function exportChipSprite(params:ArpParams = null):AChipSprite {
		var result:RectChipSprite = new RectChipSprite(this);
		result.refresh(params);
		return result;
	}
	*/

}

#end
