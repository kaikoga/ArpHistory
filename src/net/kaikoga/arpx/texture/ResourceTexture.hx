package net.kaikoga.arpx.texture;

import net.kaikoga.arpx.backends.flash.texture.ITextureFlashImpl;
import net.kaikoga.arpx.backends.flash.texture.ResourceTextureFlashImpl;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("texture", "resource"))
class ResourceTexture extends Texture
{
	@:arpValue public var src:String;

	#if arp_backend_flash

	override private function createImpl():ITextureFlashImpl return new ResourceTextureFlashImpl(this);

	public function new () {
		super();
	}

	@:arpHeatUp private function heatUp():Bool return cast(this.flashImpl, ResourceTextureFlashImpl).heatUp();
	@:arpHeatDown private function heatDown():Bool return cast(this.flashImpl, ResourceTextureFlashImpl).heatDown();

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}
