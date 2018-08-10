package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import arpx.impl.heaps.texture.TextureFaceImpl;
import arpx.impl.cross.texture.ITextureImplBase;
import arpx.structs.IArpParamsRead;

interface ITextureImpl extends ITextureImplBase {
	function getFaceInfo(params:IArpParamsRead = null):TextureFaceImpl;
}

#end
