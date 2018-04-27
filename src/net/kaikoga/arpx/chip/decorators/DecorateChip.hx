package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.paramsOp.ParamsOp;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.DecorateChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.decorators.DecorateChipHeapsImpl;
#end

@:arpType("chip", "decorate")
class DecorateChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField @:arpBarrier public var paramsOp:ParamsOp;
	@:arpField public var a:Float = 1;
	@:arpField public var b:Float = 0;
	@:arpField public var c:Float = 0;
	@:arpField public var d:Float = 1;
	@:arpField public var x:Float = 0;
	@:arpField public var y:Float = 0;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:DecorateChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:DecorateChipHeapsImpl;
	#end

	public function new() super();
}
