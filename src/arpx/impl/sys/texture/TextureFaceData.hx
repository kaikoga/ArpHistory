package arpx.impl.sys.texture;

#if arp_display_backend_sys

class TextureFaceData {

	public function new() return;
	public function dispose():Void return;
	public function trim(x:Float, y:Float, w:Float, h:Float):TextureFaceData return new TextureFaceData();

}

#end
