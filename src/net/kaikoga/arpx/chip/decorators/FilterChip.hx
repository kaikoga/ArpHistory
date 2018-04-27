package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.paramsOp.ParamsOp;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.FilterChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.decorators.FilterChipHeapsImpl;
#end

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FilterChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:FilterChipHeapsImpl;
	#end

	public function new() super();
}
