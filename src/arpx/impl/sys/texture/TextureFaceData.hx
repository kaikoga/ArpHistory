package arpx.impl.sys.texture;

#if (arp_display_backend_sys || arp_backend_display)

import arpx.impl.cross.geom.RectImpl;

class TextureFaceData {

	public var width(get, null):Int;
	inline private function get_width():Int return 0;
	public var height(get, null):Int;
	inline private function get_height():Int return 0;

	public function new() return;
	public function dispose():Void return;
	public function trim(x:Float, y:Float, w:Float, h:Float, layoutSize:RectImpl = null):TextureFaceData return new TextureFaceData();

}

#end