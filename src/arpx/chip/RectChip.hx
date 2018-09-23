package arpx.chip;

import arpx.impl.cross.chip.RectChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;

@:arpType("chip", "rect")
class RectChip extends Chip {

	@:arpField public var baseX:Int;
	@:arpField public var baseY:Int;
	@:arpField public var chipWidth:Int;
	@:arpField public var chipHeight:Int;
	@:arpField public var color:ArpColor;
	@:arpField public var border:ArpColor;

	override public function chipWidthOf(params:ArpParams):Int return this.chipWidth;
	override public function chipHeightOf(params:ArpParams):Int return this.chipHeight;
	override public function hasFace(face:String):Bool return true;

	@:arpImpl private var arpImpl:RectChipImpl;

	public function new () super();
}
