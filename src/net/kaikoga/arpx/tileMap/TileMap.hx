package net.kaikoga.arpx.tileMap;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.faceList.FaceList;
import net.kaikoga.arpx.tileInfo.TileInfo;

@:arpType("tileMap", "null")
class TileMap implements IArpObject {

	@:arpField public var width:Int;
	@:arpField public var height:Int;
	@:arpBarrier @:arpField public var faceList:FaceList;
	@:arpBarrier @:arpField public var tileInfo:TileInfo;

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
