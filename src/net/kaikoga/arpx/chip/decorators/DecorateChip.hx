package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.paramsOp.ParamsOp;
import net.kaikoga.arpx.impl.cross.chip.decorators.DecorateChipImpl;

@:arpType("chip", "decorate")
class DecorateChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;
	@:arpField public var a:Float = 1;
	@:arpField public var b:Float = 0;
	@:arpField public var c:Float = 0;
	@:arpField public var d:Float = 1;
	@:arpField public var x:Float = 0;
	@:arpField public var y:Float = 0;

	@:arpImpl private var arpImpl:DecorateChipImpl;

	public function new() super();
}
