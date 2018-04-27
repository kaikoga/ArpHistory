package net.kaikoga.arpx.backends.cross.texture;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.structs.IArpParamsRead;

interface ITextureImpl extends IArpObjectImpl {
	var width(get, never):Int;
	var height(get, never):Int;
	function widthOf(index:Int):Int;
	function heightOf(index:Int):Int;
	function getFaceIndex(params:IArpParamsRead = null):Int;
}
