package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.graphics2.Graphics;
import kha.math.Vector2;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.stringChip.StringChipDrawCursor;
import net.kaikoga.arpx.chip.stringChip.StringChipStringIterator;
import net.kaikoga.arpx.chip.StringChip;
import net.kaikoga.arpx.geom.ITransform;

class StringChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:StringChip;

	public function new(chip:StringChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var pt:Vector2 = transform.toPoint();
		var cursor:StringChipDrawCursor = new StringChipDrawCursor(pt.x, pt.y, params);
		transform = transform.toCopy();
		for (char in new StringChipStringIterator(params.get("face"))) {
			params = cursor.move(char, this.chip, this.chip.chip);
			if (params != null) {
				this.chip.chip.copyChip(g2, transform._setXY(cursor.x, cursor.y), params);
			}
		}
	}
}

#end
