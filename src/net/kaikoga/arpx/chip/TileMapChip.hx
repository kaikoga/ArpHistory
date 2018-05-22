package net.kaikoga.arpx.chip;

import net.kaikoga.arpx.impl.cross.chip.TileMapChipImpl;
import net.kaikoga.arpx.tileMap.TileMap;

@:arpType("chip", "tileMap")
class TileMapChip extends Chip {

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

	@:arpImpl private var arpImpl:TileMapChipImpl;

	public function new() super();
}
