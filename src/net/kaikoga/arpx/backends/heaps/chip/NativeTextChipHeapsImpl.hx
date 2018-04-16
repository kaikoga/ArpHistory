package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h3d.Vector;
import h2d.Font;
import h2d.Sprite;
import h2d.Text;
import h3d.col.Point;
import hxd.Charset;
import hxd.res.FontBuilder;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
import net.kaikoga.arpx.chip.NativeTextChip;

class NativeTextChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:NativeTextChip;
	private var font:Font;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		if (this.font == null) {
			font = FontBuilder.getFont(this.chip.font, this.chip.fontSize, {
				antiAliasing: false,
				chars: Charset.DEFAULT_CHARS,
				kerning: true,
			});
		}
		return true;
	}

	override public function arpHeatDown():Bool {
		this.font.dispose();
		this.font = null;
		return true;
	}

	public function copyChip(buf:Sprite, transform:ITransform, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		// if (text == null) text = "null";

		var t:Text = new Text(this.font, buf);
		t.text = text;
		t.textColor = this.chip.color.value32;
		var pt:Point = transform.toPoint();
		t.x = pt.x;
		t.y = pt.y;
	}
}

#end
