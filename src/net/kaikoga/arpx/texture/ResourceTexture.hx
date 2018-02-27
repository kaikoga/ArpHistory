package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.ResourceTextureFlashImpl;

@:arpType("texture", "resource")
class ResourceTexture extends Texture
{
	@:arpField public var src:String;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var impl:ResourceTextureFlashImpl;
#end

	public function new () {
		super();
	}

}
