package arpx.chip;

import arpx.impl.cross.chip.NativeTextChipImpl;
import arpx.structs.ArpColor;
import arpx.structs.ArpParams;

@:arpType("chip", "nativeText")
class NativeTextChip extends Chip {

	@:arpField public var chipWidth:Float = 100;
	@:arpField public var chipHeight:Float = 100;

	@:arpField public var font:String = "_sans";
	@:arpField public var fontSize:Int = 12;
	@:arpField public var color:ArpColor = new ArpColor(0xff000000);

	override public function chipWidthOf(params:ArpParams):Float return this.chipWidth;
	override public function chipHeightOf(params:ArpParams):Float return this.chipHeight;

	@:arpImpl private var arpImpl:NativeTextChipImpl;

	public function new() super();
}


