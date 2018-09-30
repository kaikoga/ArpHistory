package arpx.chip;

import arpx.chip.stringChip.StringChipStringIterator;
import arpx.impl.cross.chip.StringChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "string")
class StringChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpField public var chipWidth:Float;
	@:arpField public var chipHeight:Float;

	@:arpField public var isProportional:Bool;
	@:arpField public var orientation:Int;

	@:arpBarrier @:arpField public var chip:Chip;

	// FIXME use StringChipDrawCursor, without RenderContext
	override public function layoutSize(params:ArpParams, rect:RectImpl):RectImpl {
		var chip:Chip = this.chip;
		params = _workParams.copyFrom(params);
		var lineWidth:Float = 0;
		var width:Float = 0;
		var height:Float = 0;
		for (char in new StringChipStringIterator(params.get("face"))) {
			switch (char) {
				case "\t":
					lineWidth += this.chip.chipWidth * 4;
				case "\n":
					width = if (width > lineWidth) width else lineWidth;
					height += this.chip.chipHeight;
					lineWidth = 0;
				default:
					params.set("face", char);
					lineWidth += (this.isProportional) ? this.chip.chipWidthOf(params) : this.chip.chipWidth;
					break;
			}
		}
		width = if (width > lineWidth) width else lineWidth;
		rect.reset(0, 0, width, height);
		return rect;
	}

	@:arpImpl private var arpImpl:StringChipImpl;

	public function new () super();
}


