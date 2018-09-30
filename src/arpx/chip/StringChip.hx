package arpx.chip;

import arpx.chip.stringChip.StringChipCursor;
import arpx.chip.stringChip.StringChipStringIterator;
import arpx.impl.cross.chip.StringChipImpl;
import arpx.impl.cross.geom.RectImpl;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "string")
class StringChip extends Chip {

	@:arpField public var chipWidth:Float;
	@:arpField public var chipHeight:Float;

	@:arpField public var isProportional:Bool;
	@:arpField public var orientation:Int;

	@:arpBarrier @:arpField public var chip:Chip;

	override public function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl {
		var left:Float = 0;
		var top:Float = 0;
		var right:Float = 0;
		var bottom:Float = 0;
		var cursor:StringChipCursor = new StringChipCursor(this, params);
		for (char in new StringChipStringIterator(params.get("face"))) {
			if (cursor.move(char)) {
				var layoutChar:RectImpl = cursor.layoutChar(_workRect);
				var charRight:Float = layoutChar.x + layoutChar.width;
				var charBottom:Float = layoutChar.y + layoutChar.height;
				if (left > layoutChar.x) left = layoutChar.x;
				if (top > layoutChar.y) top = layoutChar.y;
				if (right < charRight) right = charRight;
				if (bottom < charBottom) bottom = charBottom;
			}
		}
		rect.reset(left, top, right - left, bottom - top);
		return rect;
	}

	@:arpImpl private var arpImpl:StringChipImpl;

	public function new () super();
}


