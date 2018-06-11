package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.FilterChipImpl;
import arpx.paramsOp.ParamsOp;

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

	@:arpImpl private var arpImpl:FilterChipImpl;

	public function new() super();
}
