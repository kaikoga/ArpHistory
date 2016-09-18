package net.kaikoga.arpx.mortal;

import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
import net.kaikoga.arpx.backends.flash.mortal.TileMapMortalFlashImpl;
import net.kaikoga.arpx.tileMap.TileMap;
import net.kaikoga.arpx.chip.Chip;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("mortal", "tileMap"))
class TileMapMortal extends Mortal
{

	@:arpBarrier @:arpField public var chip:Chip;
	@:arpBarrier @:arpField public var tileMap:TileMap;

	#if arp_backend_flash

	override private function createImpl():IMortalFlashImpl return new TileMapMortalFlashImpl(this);

	public function new () {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}


