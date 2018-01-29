package net.kaikoga.arpx.backends.cross.texture;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface ITextureImpl extends IArpObjectImpl {
	var width(get, set):Int;
	var height(get, set):Int;
	function widthOf(index:Int):Int;
	function heightOf(index:Int):Int;
	function getFaceIndex(params:IArpParamsRead = null):Int;
}
