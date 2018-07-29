package arpx.impl.sys.texture.decorators;

#if arp_display_backend_sys

import arpx.texture.decorators.GridTexture;

class GridTextureImpl extends MultiTextureImplBase<GridTexture> {

	public function new(texture:GridTexture) {
		super(texture);
	}
}

#end
