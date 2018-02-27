package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.file.File;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.texture.FileTextureFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.texture.FileTextureKhaImpl;
#end

@:arpType("texture", "file")
class FileTexture extends Texture
{
	@:arpField @:arpBarrier public var file:File;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:FileTextureFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:FileTextureKhaImpl;
	#end

	public function new() super();
}
