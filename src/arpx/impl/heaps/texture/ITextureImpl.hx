package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import arpx.impl.cross.texture.ITextureImplBase;
import arpx.structs.IArpParamsRead;
import h2d.Tile;

interface ITextureImpl extends ITextureImplBase {
	function getTile(params:IArpParamsRead = null):Tile;
}

#end
