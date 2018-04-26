package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.graphics2.Graphics;
import kha.math.Vector2;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.geom.ITransform;

class NativeTextChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";
		// g2.font = this.chip.font;
		g2.fontSize = this.chip.fontSize;
		var pt:Vector2 = transform.asPoint();
		g2.drawCharacters([64], 0, 1, pt.x, pt.y);
	}
}

#end
