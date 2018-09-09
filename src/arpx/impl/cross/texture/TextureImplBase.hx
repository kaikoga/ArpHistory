package arpx.impl.cross.texture;

import arpx.impl.ArpObjectImplBase;
import arpx.structs.IArpParamsRead;

class TextureImplBase extends ArpObjectImplBase {

	public var width(get, never):Int;
	private function get_width():Int return 0;
	public var height(get, never):Int;
	private function get_height():Int return 0;

	public function widthOf(params:IArpParamsRead = null):Int return this.width;
	public function heightOf(params:IArpParamsRead = null):Int return this.height;
	public function getFaceIndex(params:IArpParamsRead = null):Int return 0;

	public function new() super();
}
