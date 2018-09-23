package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.FilterChipImpl;
import arpx.paramsOp.ParamsOp;
import arpx.structs.ArpParams;

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

	@:arpImpl private var arpImpl:FilterChipImpl;

	override private function get_chipWidth():Int return chip.chipWidth;
	override private function get_chipHeight():Int return chip.chipHeight;

	override public function chipWidthOf(params:ArpParams):Int return chip.chipWidthOf(params);
	override public function chipHeightOf(params:ArpParams):Int return chip.chipHeightOf(params);

	public function new() super();
}
