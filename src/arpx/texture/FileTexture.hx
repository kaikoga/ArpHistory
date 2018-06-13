package arpx.texture;

import arpx.file.File;

#if (arp_display_backend_flash || arp_display_backend_openfl)
import arpx.impl.backends.flash.texture.FileTextureFlashImpl;
#elseif arp_display_backend_heaps
import arpx.impl.backends.heaps.texture.FileTextureHeapsImpl;
#end

@:arpType("texture", "file")
class FileTexture extends Texture
{
	@:arpField @:arpBarrier public var file:File;

	#if (arp_display_backend_flash || arp_display_backend_openfl)
	@:arpImpl private var flashImpl:FileTextureFlashImpl;
	#elseif arp_display_backend_heaps
	@:arpImpl private var heapsImpl:FileTextureHeapsImpl;
	#end

	public function new() super();
}
