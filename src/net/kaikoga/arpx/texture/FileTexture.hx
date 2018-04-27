package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.file.File;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.FileTextureFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.texture.FileTextureHeapsImpl;
#end

@:arpType("texture", "file")
class FileTexture extends Texture
{
	@:arpField @:arpBarrier public var file:File;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FileTextureFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:FileTextureHeapsImpl;
	#end

	public function new() super();
}
