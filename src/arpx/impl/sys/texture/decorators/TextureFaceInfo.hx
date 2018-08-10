package arpx.impl.sys.texture.decorators;

#if arp_display_backend_sys

class TextureFaceInfo {

	public function new() return;
	public function dispose():Void return;
	public static function trimmed(x:Float, y:Float, w:Float, h:Float):TextureFaceInfo return new TextureFaceInfo();

}

#end
