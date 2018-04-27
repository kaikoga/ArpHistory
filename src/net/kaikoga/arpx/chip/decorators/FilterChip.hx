package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.backends.cross.chip.decorators.FilterChipImpl;
import net.kaikoga.arpx.paramsOp.ParamsOp;

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

	@:arpImpl private var arpImpl:FilterChipImpl;

	public function new() super();
}
