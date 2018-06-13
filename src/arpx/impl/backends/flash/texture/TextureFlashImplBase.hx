package arpx.impl.backends.flash.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.texture.ITextureImpl;
import arpx.structs.IArpParamsRead;

class TextureFlashImplBase extends ArpObjectImplBase implements ITextureImpl {

	public var width(get, never):Int;
	private function get_width():Int return 0;
	public var height(get, never):Int;
	private function get_height():Int return 0;

	public function widthOf(index:Int):Int return this.width;
	public function heightOf(index:Int):Int return this.height;
	public function getFaceIndex(params:IArpParamsRead = null):Int return 0;

	public function new() {
		super();
	}
}

#end