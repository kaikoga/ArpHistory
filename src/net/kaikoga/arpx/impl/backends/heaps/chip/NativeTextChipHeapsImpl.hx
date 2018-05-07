package net.kaikoga.arpx.impl.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Font;
import h2d.Text;
import h3d.col.Point;
import hxd.Charset;
import hxd.res.FontBuilder;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;
import net.kaikoga.arpx.impl.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.NativeTextChip;

class NativeTextChipHeapsImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;
	private var chars:String;
	private var font:Font;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		this.chars = Charset.DEFAULT_CHARS;
		return true;
	}

	override public function arpHeatDown():Bool {
		this.font.dispose();
		this.font = null;
		return true;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";

		for (i in 0...text.length) {
			var char:String = text.charAt(i);
			if (this.chars.indexOf(char) < 0) {
				this.chars += char;
				if (this.font != null) this.font.dispose();
				this.font = null;
			}
		}

		if (this.font == null) {
			var fontName:String = this.chip.font;
			if (fontName == null) fontName = "_sans";
			this.font = @:privateAccess new FontBuilder(fontName, this.chip.fontSize, {
				antiAliasing: false,
				chars: chars,
				kerning: true
			}).build();
			this.font.charset = CharsetCjk.instance;
		}

		var t:Text = new Text(this.font, context.buf);
		t.maxWidth = this.chip.chipWidth;
		t.letterSpacing = 0;
		t.text = text;
		t.textColor = this.chip.color.value32;
		var pt:Point = context.transform.toPoint();
		t.x = pt.x;
		t.y = pt.y - this.chip.fontSize + 2;
	}
}

private class CharsetCjk extends Charset {
	override public function isCJK(code) {
		if (code >= 0x2E80 && code <= 0x9FFF) return true;
		if (code >= 0xAC00 && code <= 0xFAFF) return true;
		if (code >= 0x1F000) return true;
		return false;
	}

	@:isVar public static var instance(get, null):Charset;
	private static function get_instance():Charset return if (instance != null) instance else instance = new CharsetCjk();
}
#end
