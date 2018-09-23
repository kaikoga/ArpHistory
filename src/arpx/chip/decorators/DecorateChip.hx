package arpx.chip.decorators;

import arpx.impl.cross.chip.decorators.DecorateChipImpl;
import arpx.paramsOp.ParamsOp;
import arpx.structs.ArpParams;

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

	override private function get_chipWidth():Int return Std.int(chip.chipWidth * a);
	override private function get_chipHeight():Int return Std.int(chip.chipHeight * d);

	override public function chipWidthOf(params:ArpParams):Int return Std.int(chip.chipWidthOf(params) * a);

	override public function chipHeightOf(params:ArpParams):Int return Std.int(chip.chipHeightOf(params) * d);

	override public function hasFace(face:String):Bool return chip.hasFace(face);

	public function new() super();
}
