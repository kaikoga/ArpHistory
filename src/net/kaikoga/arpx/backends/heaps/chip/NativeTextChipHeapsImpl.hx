package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Font;
import h2d.Sprite;
import h2d.Text;
import h3d.Vector;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.math.ITransform;
import net.kaikoga.arpx.chip.NativeTextChip;

class NativeTextChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";
		
		/*
		var t:Text = new Text(new Font(this.chip.font, this.chip.fontSize), buf);
		t.text = text;
		var pt:Vector = transform.asPoint();
		t.x = pt.x;
		t.y = pt.y;
		*/ 
	}
}

#end
