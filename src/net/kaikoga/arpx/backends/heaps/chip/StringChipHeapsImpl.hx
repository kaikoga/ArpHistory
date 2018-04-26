package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h3d.col.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.geom.ITransform;

class StringChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:Point = context.transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params);
		var transform:ITransform = context.transform.toCopy();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				context.pushTransform(transform._setXY(cursor.x, cursor.y));
				this.chip.chip.copyChip(context, params);
				context.popTransform();
			}
		}
	}
}

#end
