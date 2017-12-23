package net.kaikoga.arpx.mortal;

import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.flash.mortal.ChipMenuMortalFlashImpl;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.menu.Menu;

@:arpType("mortal", "chipMenu")
class ChipMenuMortal extends Mortal {

	@:arpField public var chip:Chip;
	@:arpField public var dPosition:ArpPosition;
	@:arpField public var menu:Menu;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMenuMortalFlashImpl;
	#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
	}
}
