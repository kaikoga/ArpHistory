package arpx.impl.heaps.chip;

#if arp_display_backend_heaps

import arpx.impl.cross.geom.PointImpl;
import h2d.Font;
import h2d.Text;
import hxd.Charset;
import hxd.res.FontBuilder;
import arpx.structs.IArpParamsRead;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.chip.IChipImpl;
import arpx.impl.heaps.display.DisplayContext;
import arpx.chip.NativeTextChip;

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

	private var _workPt:PointImpl = new PointImpl();
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
		var pt:PointImpl = context.transform.toPoint(_workPt);
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
