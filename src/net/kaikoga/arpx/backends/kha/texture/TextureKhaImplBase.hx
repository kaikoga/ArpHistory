package net.kaikoga.arpx.backends.kha.texture;

#if arp_backend_kha

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;

class TextureKhaImplBase extends ArpObjectImplBase implements ITextureImpl {

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
