package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.tileMap.TileMap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.TileMapChipFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.TileMapChipHeapsImpl;
#end

@:arpType("chip", "tileMap")
class TileMapChip extends Chip {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TileMapChipFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:TileMapChipHeapsImpl;
	#end

	public function new() super();
}
