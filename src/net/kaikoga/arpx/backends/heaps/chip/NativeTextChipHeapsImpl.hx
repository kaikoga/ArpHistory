package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Font;
import h2d.Text;
import h3d.col.Point;
import hxd.Charset;
import hxd.res.FontBuilder;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.NativeTextChip;

class NativeTextChipHeapsImpl extends ArpObjectImplBase implements IChipHeapsImpl {

	private var chip:NativeTextChip;
	private var charset:String;
	private var font:Font;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		this.charset = Charset.DEFAULT_CHARS;
		return true;
	}

	override public function arpHeatDown():Bool {
		this.font.dispose();
		this.font = null;
		return true;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";

		for (i in 0...text.length) {
			var char:String = text.charAt(i);
			if (this.charset.indexOf(char) < 0) {
				this.charset += char;
				if (this.font != null) this.font.dispose();
				this.font = null;
			}
		}

		if (this.font == null) {
			this.font = @:privateAccess new FontBuilder(this.chip.font, this.chip.fontSize, {
				antiAliasing: false,
				chars: charset,
				kerning: true
			}).build();
		}

		var t:Text = new Text(this.font, context.buf);
		t.maxWidth = this.chip.chipWidth;
		t.text = text;
		t.textColor = this.chip.color.value32;
		var pt:Point = context.transform.toPoint();
		t.x = pt.x;
		t.y = pt.y - this.chip.fontSize + 2;
	}
}

#end
