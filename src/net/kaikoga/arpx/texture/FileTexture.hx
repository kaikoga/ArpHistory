package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.FileTextureFlashImpl;
import net.kaikoga.arpx.file.File;
import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("texture", "file"))
class FileTexture extends Texture
{
	@:arpType("file") @:arpBarrier public var file:File;

	#if arp_backend_flash

	override private function createImpl():ITextureFlashImpl return new FileTextureFlashImpl(this);

	public function new () {
		super();
	}

	public function heatUp():Bool return cast(this.flashImpl, FileTextureFlashImpl).heatUp();
	public function heatDown():Bool return cast(this.flashImpl, FileTextureFlashImpl).heatDown();

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
