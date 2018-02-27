package net.kaikoga.arpx.chip.decorators;

import net.kaikoga.arpx.paramsOp.ParamsOp;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.DecorateChipFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.chip.decorators.DecorateChipKhaImpl;
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
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:DecorateChipKhaImpl;
	#end

	public function new() super();
}
