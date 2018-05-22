package net.kaikoga.arpx.impl.backends.heaps.texture;

#if arp_backend_heaps

import net.kaikoga.arpx.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.texture.ITextureImpl;

class TextureHeapsImplBase extends ArpObjectImplBase implements ITextureImpl {

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
