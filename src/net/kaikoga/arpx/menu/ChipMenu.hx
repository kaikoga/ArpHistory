package net.kaikoga.arpx.menu;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arpx.backends.flash.menu.ChipMenuFlashImpl;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.text.TextData;

@:arpType("menu", "chip")
class ChipMenu extends Menu {

	@:arpField public var chip:Chip;
	@:arpField public var position:ArpPosition;
	@:arpField public var dPosition:ArpPosition;
	@:arpField("text") public var texts:IOmap<String, TextData>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ChipMenuFlashImpl;
	#else
	@:arpWithoutBackend
#end
	public function new() {
		super();
	}
}
