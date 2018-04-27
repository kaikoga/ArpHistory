package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.ChipHudFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.hud.ChipHudHeapsImpl;
#end

@:arpType("hud", "chip")
class ChipHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipHudFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:ChipHudHeapsImpl;
	#end

	public function new() super();
}


