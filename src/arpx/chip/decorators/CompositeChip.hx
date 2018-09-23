package arpx.chip.decorators;

import arp.ds.IList;
import arpx.impl.cross.chip.decorators.CompositeChipImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	@:arpImpl private var arpImpl:CompositeChipImpl;

	override private function get_baseX():Int return 0;
	override private function get_baseY():Int return 0;
	override private function get_chipWidth():Int return chips.first().chipWidth;
	override private function get_chipHeight():Int return chips.first().chipHeight;

	override public function chipWidthOf(params:ArpParams):Int return chips.first().chipWidthOf(params);

	override public function chipHeightOf(params:ArpParams):Int return chips.first().chipHeightOf(params);

	override public function hasFace(face:String):Bool return chips.first().hasFace(face);

	public function new() super();
}
