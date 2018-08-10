package arpx.impl.heaps.texture.decorators;

#if arp_display_backend_heaps

import h2d.Tile;

abstract TextureFaceInfo(Tile) {

	inline public function new(tile:Tile) this = tile;

	public var tile(get, never):Tile;
	inline private function get_tile():Tile return this;

	inline public static function trimmed(source:Tile, x:Float, y:Float, w:Float, h:Float):TextureFaceInfo {
		return new TextureFaceInfo(source.sub(Std.int(x), Std.int(y), Std.int(w), Std.int(h)));
	}

	inline public function dispose():Void this.dispose();
}

#end
