package net.kaikoga.arpx.chip;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("chip", "null"))
class Chip implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IChipFlashImpl #end
{

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

	#if (arp_backend_flash || arp_backend_openfl)

	private var flashImpl:IChipFlashImpl;

	private function createImpl():IChipFlashImpl return null;

	public function new() {
		flashImpl = createImpl();
	}

	inline public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		flashImpl.copyChip(bitmapData, transform, params);
	}

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
}
