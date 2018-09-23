package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.TranslateChipImpl;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpParams;

@:arpType("chip", "transform")
class TransformChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var transform:ArpTransform;

	@:arpImpl private var flashImpl:TranslateChipImpl;

	override private function get_chipWidth():Float return chip.chipWidth * transform.impl.xx;
	override private function get_chipHeight():Float return chip.chipHeight * transform.impl.yy;

	override public function chipWidthOf(params:ArpParams):Float return chip.chipWidthOf(params) * transform.impl.xx;
	override public function chipHeightOf(params:ArpParams):Float return chip.chipHeightOf(params) * transform.impl.yy;

	public function new() super();
}
