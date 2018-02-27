package net.kaikoga.arpx.texture;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.ResourceTextureFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.texture.ResourceTextureKhaImpl;
#end

@:arpType("texture", "resource")
class ResourceTexture extends Texture
{
	@:arpField public var src:String;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ResourceTextureFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:ResourceTextureKhaImpl;
	#end

	public function new() super();
}
