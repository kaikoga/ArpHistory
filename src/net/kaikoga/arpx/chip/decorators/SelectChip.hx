package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arpx.impl.cross.chip.decorators.SelectChipImpl;

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	@:arpImpl private var arpImpl:SelectChipImpl;

	public function new() super();
}
