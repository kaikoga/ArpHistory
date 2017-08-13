package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.tileMap.TileMap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.TileMapChipFlashImpl;
#end

@:arpType("chip", "tileMap")
class TileMapChip extends Chip {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TileMapChipFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}
