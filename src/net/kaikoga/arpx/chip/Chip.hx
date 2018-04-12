package net.kaikoga.arpx.chip;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.IChipFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.chip.IChipKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.IChipHeapsImpl;
#end

@:arpType("chip", "null")
class Chip implements IArpObject
	#if (arp_backend_flash || arp_backend_openfl) implements IChipFlashImpl #end
	#if arp_backend_kha implements IChipKhaImpl #end
	#if arp_backend_heaps implements IChipHeapsImpl #end
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
	@:arpImpl private var flashImpl:IChipFlashImpl;
	#end
	#if (arp_backend_kha)
	@:arpImpl private var khaImpl:IChipKhaImpl;
	#end
	#if (arp_backend_heaps)
	@:arpImpl private var heapsImpl:IChipHeapsImpl;
	#end

	public function new () {
	}

}
