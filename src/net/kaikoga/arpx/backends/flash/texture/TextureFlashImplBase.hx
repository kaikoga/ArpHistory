package net.kaikoga.arpx.backends.flash.texture;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;
import net.kaikoga.arpx.backends.ArpObjectImplBase;

class TextureFlashImplBase extends ArpObjectImplBase implements ITextureImpl {

	public var width(get, set):Int;
	private function get_width():Int return 0;
	private function set_width(value:Int):Int return value; // FIXME
	public var height(get, set):Int;
	private function get_height():Int return 0;
	private function set_height(value:Int):Int return value; // FIXME

	public function widthOf(index:Int):Int return this.width;
	public function heightOf(index:Int):Int return this.height;
	public function getFaceIndex(params:IArpParamsRead = null):Int return 0;

	public function new() {
		super();
	}
}


