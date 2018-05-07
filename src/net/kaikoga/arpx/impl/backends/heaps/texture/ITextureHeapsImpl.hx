package net.kaikoga.arpx.impl.backends.heaps.texture;

#if arp_backend_heaps

import h2d.Tile;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.cross.texture.ITextureImpl;

interface ITextureHeapsImpl extends ITextureImpl {
	function getTile(params:IArpParamsRead = null):Tile;
}

#end
