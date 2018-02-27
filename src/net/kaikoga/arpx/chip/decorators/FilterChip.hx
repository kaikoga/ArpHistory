package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.paramsOp.ParamsOp;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.FilterChipFlashImpl;
#end

@:arpType("chip", "filter")
class FilterChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FilterChipFlashImpl;
#end

	public function new() super();
}
