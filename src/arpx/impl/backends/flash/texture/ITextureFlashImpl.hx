package arpx.impl.backends.flash.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import arpx.impl.backends.flash.texture.decorators.TextureFaceInfo;
import arpx.impl.cross.texture.ITextureImpl;
import arpx.structs.IArpParamsRead;

interface ITextureFlashImpl extends ITextureImpl {
	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end
