package arpx.chip.decorators;

import arp.ds.IMap;
import arpx.impl.cross.chip.decorators.SelectChipImpl;
import arpx.structs.ArpParams;
import arpx.structs.IArpParamsRead;

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	@:arpImpl private var arpImpl:SelectChipImpl;

	override private function get_chipWidth():Int return this.select(null).chipWidth;
	override private function get_chipHeight():Int return this.select(null).chipHeight;

	override public function chipWidthOf(params:ArpParams):Int return this.select(params).chipWidthOf(params);
	override public function chipHeightOf(params:ArpParams):Int return this.select(params).chipHeightOf(params);

	override public function hasFace(face:String):Bool return this.select(null).hasFace(face);

	public function new() super();

	private function select(params:IArpParamsRead = null):Chip {
		if (params == null) return this.chips.get(this.defaultKey);
		return this.chips.get(params.getAsString(this.selector, this.defaultKey));
	}
}
