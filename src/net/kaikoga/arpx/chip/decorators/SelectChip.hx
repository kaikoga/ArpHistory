package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IMap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.SelectChipFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.chip.decorators.SelectChipKhaImpl;
#end

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:SelectChipFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:SelectChipKhaImpl;
	#end

	public function new() super();
}
