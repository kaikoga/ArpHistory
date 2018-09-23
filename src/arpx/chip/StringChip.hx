package arpx.chip;

import arpx.chip.stringChip.StringChipStringIterator;
import arpx.impl.cross.chip.StringChipImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "string")
class StringChip extends Chip {

	private static var _workParams:ArpParams = new ArpParams();

	@:arpField public var chipWidth:Float;
	@:arpField public var chipHeight:Float;

	@:arpField public var isProportional:Bool;
	@:arpField public var orientation:Int;

	@:arpBarrier @:arpField public var chip:Chip;

	override public function chipWidthOf(params:ArpParams):Float {
		if (params == null) {
			return 0;
		}
		var chip:Chip = this.chip;
		params = _workParams.copyFrom(params);
		var width:Float = 0;
		var result:Float = 0;
		for (char in new StringChipStringIterator(params.get("face"))) {
			switch (char) {
				case "\t":
					width += this.chip.chipWidth * 4;
				case "\n":
					result = (result > width) ? result : width;
					width = 0;
				default:
					params.set("face", char);
					width += (this.isProportional) ? this.chip.chipWidthOf(params) : this.chip.chipWidth;
					break;
			}
		}
		return ((result > width)) ? result : width;
	}

	override public function chipHeightOf(params:ArpParams):Float {
		if (params == null) {
			return 0;
		}
		var chip:Chip = this.chip;
		params = _workParams.copyFrom(params);
		var result:Float = this.chip.chipHeight;
		for (char in new StringChipStringIterator(params.get("face"))) {
			if (char == "\n") result += this.chip.chipHeight;
		}
		return result;
	}

	@:arpImpl private var arpImpl:StringChipImpl;

	public function new () super();
}


