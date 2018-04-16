package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Sprite;
import h3d.col.Point;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;

class StringChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void {
		var pt:Point = transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params);
		transform = transform.toCopy();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				this.chip.chip.copyChip(buf, transform._setXY(cursor.x, cursor.y), params);
			}
		}
	}
}

#end
