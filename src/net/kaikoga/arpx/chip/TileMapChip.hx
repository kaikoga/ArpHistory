package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.tileMap.TileMap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.chip.TileMapChipFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.chip.TileMapChipKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.chip.TileMapChipHeapsImpl;
#end

@:arpType("chip", "tileMap")
class TileMapChip extends Chip {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TileMapChipFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:TileMapChipKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:TileMapChipHeapsImpl;
	#end

	public function new () {
		super();
	}
}
