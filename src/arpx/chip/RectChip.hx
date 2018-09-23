package arpx.chip;

import arpx.impl.cross.chip.RectChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;

@:arpType("chip", "rect")
class RectChip extends Chip {

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Float;
	@:arpField public var chipHeight:Float;
	@:arpField public var color:ArpColor;
	@:arpField public var border:ArpColor;

	override public function chipWidthOf(params:ArpParams):Float return this.chipWidth;
	override public function chipHeightOf(params:ArpParams):Float return this.chipHeight;

	@:arpImpl private var arpImpl:RectChipImpl;

	public function new () super();
}
