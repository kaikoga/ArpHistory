package net.kaikoga.arpx.backends.cross.chip;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.APoint;
import net.kaikoga.arpx.geom.ITransform;

class StringChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:APoint = context.transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params); // FIXME
		var transform:ITransform = context.transform.toCopy();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				context.pushTransform(transform.setXY(cursor.x, cursor.y));
				this.chip.chip.copyChip(context, params);
				context.popTransform();
			}
		}
	}
}
