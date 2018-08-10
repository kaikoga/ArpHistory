package arpx.impl.flash.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arpx.impl.flash.texture.decorators.TextureFaceInfo;
import arpx.impl.cross.texture.ITextureImplBase;
import arpx.structs.IArpParamsRead;

interface ITextureImpl extends ITextureImplBase {
	function bitmapData():BitmapData;
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo;
}

#end
