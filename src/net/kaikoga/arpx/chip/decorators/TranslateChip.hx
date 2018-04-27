package net.kaikoga.arpx.chip.decorators;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.decorators.TranslateChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.decorators.TranslateChipHeapsImpl;
#end

@:arpType("chip", "translate")
class TranslateChip extends Chip {

	@:arpField @:arpBarrier public var chip:Chip;
	@:arpField public var a:Float = 1;
	@:arpField public var b:Float = 0;
	@:arpField public var c:Float = 0;
	@:arpField public var d:Float = 1;
	@:arpField public var x:Float = 0;
	@:arpField public var y:Float = 0;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TranslateChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:TranslateChipHeapsImpl;
	#end

	public function new() super();
}
