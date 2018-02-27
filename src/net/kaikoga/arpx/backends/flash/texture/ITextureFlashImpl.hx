package net.kaikoga.arpx.backends.flash.texture;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.cross.texture.ITextureImpl;
import net.kaikoga.arpx.backends.flash.texture.decorators.TextureFaceInfo;

interface ITextureFlashImpl extends ITextureImpl {
	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end
