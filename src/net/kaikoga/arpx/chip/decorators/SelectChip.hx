package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arp.ds.IMap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.SelectChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.decorators.SelectChipHeapsImpl;
#end

@:arpType("chip", "select")
class SelectChip extends Chip {

	@:arpField("chip") @:arpBarrier public var chips:IMap<String, Chip>;
	@:arpField public var selector:String;
	@:arpField public var defaultKey:String = "0";

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:SelectChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:SelectChipHeapsImpl;
	#end

	public function new() super();
}
