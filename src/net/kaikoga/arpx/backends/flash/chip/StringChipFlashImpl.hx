package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;

class StringChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:Point = context.transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params);
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				context.pushTransform(context.transform._setXY(cursor.x, cursor.y));
				this.chip.chip.copyChip(context, params);
				context.popTransform();
			}
		}
	}

	/*
	public function exportChipSprite(params:ArpParams = null):AChipSprite {
		var result:StringChipSprite = new StringChipSprite(this, this.chipWidth);
		if (params != null) {
			result.refresh(params);
		}
		return result;
	}
	*/

}

#end
