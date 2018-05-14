package net.kaikoga.arpx.impl.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.NativeTextChip;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;

class NativeTextChipFlashImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:NativeTextChip;

	public function new(chip:NativeTextChip) {
		super();
		this.chip = chip;
	}

	override public function arpHeatUp():Bool {
		if (this.visual == null) {
			this.visual = this.createVisual();
			this.ascent = this.visual.getLineMetrics(0).ascent;
		}
		return true;
	}

	override public function arpHeatDown():Bool {
		this.visual = null;
		return true;
	}

	private var visual:TextField;
	private var ascent:Float;

	public function createVisual():TextField {
		var result:TextField = new TextField();
		result.text = " ";
		result.width = this.chip.chipWidth;
		result.height = this.chip.chipHeight;
		result.autoSize = TextFieldAutoSize.NONE;
		var fontName:String = this.chip.font;
		if (fontName == null) fontName = "_sans";
		result.defaultTextFormat = new TextFormat(fontName, this.chip.fontSize, this.chip.color.value32);
		result.embedFonts = fontName.charAt(0) != "_";
		result.selectable = false;
		result.wordWrap = true;
		return result;
	}

	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		this.arpHeatUp();
		context.dupTransform().appendXY(-2, -2 - this.ascent);
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";
		this.visual.text = text;
		context.bitmapData.draw(this.visual, context.transform.toMatrix());
		context.popTransform();
	}

	/*
	public function exportChipSprite(params:ArpParams = null):AChipSprite {
		var result:NativeTextChipSprite = new NativeTextChipSprite(this, this.ascent);
		if (params != null) {
			result.refresh(params);
		}
		return result;
	}
	*/
}

#end
