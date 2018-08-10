package arpx.impl.cross.texture;

import arp.impl.IArpObjectImpl;
import arpx.structs.IArpParamsRead;

interface ITextureImplBase extends IArpObjectImpl {
	var width(get, never):Int;
	var height(get, never):Int;
	function widthOf(index:Int):Int;
	function heightOf(index:Int):Int;
	function getFaceIndex(params:IArpParamsRead = null):Int;
	function getFaceData(params:IArpParamsRead = null):TextureFaceData;
}
