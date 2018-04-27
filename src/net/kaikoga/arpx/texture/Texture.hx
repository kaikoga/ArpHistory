package net.kaikoga.arpx.texture;

import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.texture.ITextureHeapsImpl;
#end

@:arpType("texture", "null")
class Texture implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements ITextureFlashImpl
#elseif arp_backend_heaps implements ITextureHeapsImpl
#end
{
	@:arpField public var hasAlpha:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ITextureFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:ITextureHeapsImpl;
	#end

	public function new() return;
}
