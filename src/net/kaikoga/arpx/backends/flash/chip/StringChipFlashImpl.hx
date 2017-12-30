package net.kaikoga.arpx.backends.flash.chip;

import flash.display.BitmapData;
import flash.geom.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;

class StringChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var pt:Point = transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params);
		transform = transform.toCopy();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				this.chip.chip.copyChip(bitmapData, transform._setXY(cursor.x, cursor.y), params);
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

