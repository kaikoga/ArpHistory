package net.kaikoga.arpx.tileMap;

import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("tileMap", "null"))
class TileMap implements IArpObject {

	@:arpField public var width:Int;
	@:arpField public var height:Int;

	public var isInfinite(get, never):Bool;

	public function new() {
	}

	private function get_isInfinite():Bool {
		return false;
	}

	public function getTileIndexAtGrid(gridX:Int, gridY:Int):Int {
		return 0;
	}

	public function setTileIndexAtGrid(gridX:Int, gridY:Int, value:Int):Void {

	}
}
