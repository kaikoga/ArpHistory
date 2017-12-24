package net.kaikoga.arpx.hud;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.ChipHudFlashImpl;
#end

import net.kaikoga.arpx.chip.Chip;

@:arpType("hud", "chip")
class ChipHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipHudFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}


