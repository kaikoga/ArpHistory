package arpx.impl.cross.texture;

import arpx.impl.cross.geom.RectImpl;
import arp.impl.IArpObjectImpl;
import arpx.structs.IArpParamsRead;

interface ITextureImpl extends IArpObjectImpl {
	var width(get, never):Int;
	var height(get, never):Int;
	@:deprecated("use layoutSize")
	function widthOf(params:IArpParamsRead = null):Int;
	@:deprecated("use layoutSize")
	function heightOf(params:IArpParamsRead = null):Int;
	function layoutSize(params:IArpParamsRead, rect:RectImpl):RectImpl;
	function getFaceIndex(params:IArpParamsRead = null):Int;
	function getFaceData(params:IArpParamsRead = null):TextureFaceData;
}
