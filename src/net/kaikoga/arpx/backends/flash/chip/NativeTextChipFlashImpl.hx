package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.chip.NativeTextChip;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.TextField;
import flash.geom.Matrix;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;

class NativeTextChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

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
		result.autoSize = TextFieldAutoSize.LEFT;
		var fontName:String = this.chip.font;
		if (fontName == null) fontName = "_sans";
		result.defaultTextFormat = new TextFormat(fontName, this.chip.fontSize, this.chip.color.value32);
		result.embedFonts = fontName.charAt(0) != "_";
		result.selectable = false;
		return result;
	}

	private static var _workDrawMatrix:Matrix = new Matrix();
	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		this.arpHeatUp();
		transform = transform.concatXY(-2, -2 - this.ascent);
		var text:String = null;
		if (params != null) text = params.get("face");
		if (text == null) text = "null";
		this.visual.text = text;
		bitmapData.draw(this.visual, transform.toMatrix(), transform.colorTransform, transform.blendMode);
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
