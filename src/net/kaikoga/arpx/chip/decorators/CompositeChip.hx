package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.backends.cross.chip.decorators.CompositeChipImpl;

@:arpType("chip", "composite")
class CompositeChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IList<Chip>;

	@:arpImpl private var arpImpl:CompositeChipImpl;

	public function new() super();
}
