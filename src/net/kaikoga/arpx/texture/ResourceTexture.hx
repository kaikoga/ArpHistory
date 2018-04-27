package net.kaikoga.arpx.texture;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.ResourceTextureFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.texture.ResourceTextureHeapsImpl;
#end

@:arpType("texture", "resource")
class ResourceTexture extends Texture
{
	@:arpField public var src:String;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ResourceTextureFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:ResourceTextureHeapsImpl;
	#end

	public function new() super();
}
