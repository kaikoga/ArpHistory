package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.SelectChipImpl;

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	@:arpImpl private var arpImpl:SelectChipImpl;

	public function new() super();
}
