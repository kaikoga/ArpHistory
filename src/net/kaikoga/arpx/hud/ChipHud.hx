package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.ChipHudFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.hud.ChipHudKhaImpl;
#end

@:arpType("hud", "chip")
class ChipHud extends Hud {

	@:arpBarrier @:arpField public var chip:Chip;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipHudFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:ChipHudKhaImpl;
	#end

	public function new() super();
}


