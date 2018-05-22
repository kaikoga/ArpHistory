package net.kaikoga.arpx.impl.cross.chip;

import net.kaikoga.arpx.chip.RectChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;
import net.kaikoga.arpx.structs.IArpParamsRead;

class RectChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	private var _workPt:PointImpl = new PointImpl();
	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:PointImpl = context.transform.asPoint(_workPt);
		if (pt != null) {
			var l:Int = -chip.baseX;
			var t:Int = -chip.baseY;
			var w:Int = chip.chipWidth;
			var h:Int = chip.chipHeight;
			var c:Int = chip.border.value32;
			context.fillRect(l, t, w, 1, c);
			context.fillRect(l, t + h - 1, w, 1, c);
			t++;
			h -= 2;
			context.fillRect(l, t, 1, h, c);
			context.fillRect(l + w - 1, t, 1, h, c);
			context.fillRect(++l, t, w - 2, h, chip.color.value32);
		} else {
			/*
			var _workTransform:Matrix = _workMatrix;
			_workTransform.setTo(1, 0, 0, 1, -this.baseX, -this.baseY);
			_workTransform.concat(transform.toMatrix());
			bitmapData.draw(this.exportChipSprite(params), _workTransform, transform.colorTransform, transform.blendMode);
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
