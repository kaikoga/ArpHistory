package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;
import flash.display.BitmapData;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("texture", "null"))
class Texture implements IArpObject
#if arp_backend_flash implements ITextureFlashImpl #end
{
	@:arpField public var hasAlpha:Bool = true;

	#if arp_backend_flash
	private var flashImpl:ITextureFlashImpl;

	private function createImpl():ITextureFlashImpl return null;

	public function new() {
		flashImpl = createImpl();
	}

	inline public function bitmapData():BitmapData return flashImpl.bitmapData();

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
}
