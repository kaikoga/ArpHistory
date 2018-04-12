package net.kaikoga.arpx.texture;

import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.texture.ITextureKhaImpl;
#end

#if arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.texture.ITextureHeapsImpl;
#end

@:arpType("texture", "null")
class Texture implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements ITextureFlashImpl #end
#if arp_backend_kha implements ITextureKhaImpl #end
#if arp_backend_kha implements ITextureHeapsImpl #end
{
	@:arpField public var hasAlpha:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ITextureFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:ITextureKhaImpl;
	#end

	#if arp_backend_heaps
	@:arpImpl private var heapsImpl:ITextureHeapsImpl;
	#end

	public function new() return;
}
