package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;
import flash.display.BitmapData;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("texture", "null")
class Texture implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements ITextureFlashImpl #end
{
	@:arpField public var hasAlpha:Bool = true;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var arpImpl:ITextureFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
	}
}
