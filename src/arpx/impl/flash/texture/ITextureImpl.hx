package arpx.impl.flash.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arpx.impl.flash.texture.TextureFaceImpl;
import arpx.impl.cross.texture.ITextureImplBase;
import arpx.structs.IArpParamsRead;

interface ITextureImpl extends ITextureImplBase {
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceImpl;
}

#end
