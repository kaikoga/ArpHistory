package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.FileTextureFlashImpl;
import net.kaikoga.arpx.file.File;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("texture", "file"))
class FileTexture extends Texture
{
	@:arpField @:arpBarrier public var file:File;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var impl:FileTextureFlashImpl;

	@:arpHeatUp private function heatUp():Bool return cast(this.arpImpl, FileTextureFlashImpl).heatUp();
	@:arpHeatDown private function heatDown():Bool return cast(this.arpImpl, FileTextureFlashImpl).heatDown();
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}
}
