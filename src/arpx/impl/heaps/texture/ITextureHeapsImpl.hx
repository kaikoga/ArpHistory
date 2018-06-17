package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import arpx.impl.cross.texture.ITextureImplBase;
import arpx.structs.IArpParamsRead;
import h2d.Tile;

interface ITextureHeapsImpl extends ITextureImplBase {
	function getTile(params:IArpParamsRead = null):Tile;
}

#end
