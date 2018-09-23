package arpx.chip.decorators;

import arp.ds.IList;
import arpx.impl.cross.chip.decorators.CompositeChipImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	@:arpImpl private var arpImpl:CompositeChipImpl;

	override private function get_chipWidth():Float return chips.first().chipWidth;
	override private function get_chipHeight():Float return chips.first().chipHeight;

	override public function chipWidthOf(params:ArpParams):Float return chips.first().chipWidthOf(params);
	override public function chipHeightOf(params:ArpParams):Float return chips.first().chipHeightOf(params);

	public function new() super();
}
