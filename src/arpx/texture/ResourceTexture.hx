package arpx.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
import arpx.impl.backends.flash.texture.ResourceTextureFlashImpl;
#elseif arp_display_backend_heaps
import arpx.impl.backends.heaps.texture.ResourceTextureHeapsImpl;
#end

@:arpType("texture", "resource")
class ResourceTexture extends Texture
{
	@:arpField public var src:String;

	#if (arp_display_backend_flash || arp_display_backend_openfl)
	@:arpImpl private var flashImpl:ResourceTextureFlashImpl;
	#elseif arp_display_backend_heaps
	@:arpImpl private var heapsImpl:ResourceTextureHeapsImpl;
	#end

	public function new() super();
}
