package arpx.chip.decorators;

import arp.ds.IList;
import arpx.impl.cross.chip.decorators.CompositeChipImpl;

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	@:arpImpl private var arpImpl:CompositeChipImpl;

	public function new() super();
}
