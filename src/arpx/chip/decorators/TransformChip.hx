package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TranslateChipImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpParams;

@:arpType("chip", "transform")
class TransformChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var transform:ArpTransform;

	@:arpImpl private var flashImpl:TranslateChipImpl;

	override private function get_chipWidth():Int return Std.int(chip.chipWidth * transform.impl.xx);
	override private function get_chipHeight():Int return Std.int(chip.chipHeight * transform.impl.yy);

	override public function chipWidthOf(params:ArpParams):Int return Std.int(chip.chipWidthOf(params) * transform.impl.xx);
	override public function chipHeightOf(params:ArpParams):Int return Std.int(chip.chipHeightOf(params) * transform.impl.yy);

	public function new() super();
}
