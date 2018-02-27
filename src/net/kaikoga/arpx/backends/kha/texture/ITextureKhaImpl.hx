package net.kaikoga.arpx.backends.kha.texture;

#if arp_backend_kha

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;
import net.kaikoga.arpx.backends.kha.texture.decorators.TextureFaceInfo;

interface ITextureKhaImpl extends ITextureImpl {
	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end
