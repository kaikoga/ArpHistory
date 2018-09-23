package arpx.chip;

import arp.domain.IArpObject;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "null")
class Chip implements IArpObject implements IChipImpl {

	public var chipWidth(get, set):Float;
	private function get_chipWidth():Float return 0;
	private function set_chipWidth(value:Float):Float return 0;
	public var chipHeight(get, set):Float;
	private function get_chipHeight():Float return 0;
	private function set_chipHeight(value:Float):Float return 0;

	public function chipWidthOf(params:ArpParams):Float return 0;

	public function chipHeightOf(params:ArpParams):Float return 0;

	@:arpImpl private var arpImpl:IChipImpl;

	public function new() return;
}
