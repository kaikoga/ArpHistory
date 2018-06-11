package arpx.chip;

import arp.domain.IArpObject;
import arpx.impl.cross.chip.IChipImpl;
import arpx.structs.ArpParams;

@:arpType("chip", "null")
class Chip implements IArpObject implements IChipImpl {

	public var baseX(get, set):Int;
	private function get_baseX():Int return 0;
	private function set_baseX(value:Int):Int return 0;
	public var baseY(get, set):Int;
	private function get_baseY():Int return 0;
	private function set_baseY(value:Int):Int return 0;
	public var chipWidth(get, set):Int;
	private function get_chipWidth():Int return 0;
	private function set_chipWidth(value:Int):Int return 0;
	public var chipHeight(get, set):Int;
	private function get_chipHeight():Int return 0;
	private function set_chipHeight(value:Int):Int return 0;

	public function chipWidthOf(params:ArpParams):Int return 0;

	public function chipHeightOf(params:ArpParams):Int return 0;

	//TODO hasChipName must distinguish explicit and implicit existence
	public function hasFace(face:String):Bool return false;

	@:arpImpl private var arpImpl:IChipImpl;

	public function new() return;
}
