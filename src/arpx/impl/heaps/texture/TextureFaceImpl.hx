package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import h2d.Tile;

abstract TextureFaceImpl(Tile) {

	inline public function new(tile:Tile) this = tile;

	public var tile(get, never):Tile;
	inline private function get_tile():Tile return this;

	inline public function trim(x:Float, y:Float, w:Float, h:Float):TextureFaceImpl {
		return new TextureFaceImpl(this.sub(Std.int(x), Std.int(y), Std.int(w), Std.int(h)));
	}

	inline public function dispose():Void this.dispose();
}

#end
