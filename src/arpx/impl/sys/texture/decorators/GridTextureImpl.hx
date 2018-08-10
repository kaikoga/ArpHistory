package arpx.impl.sys.texture.decorators;

#if arp_display_backend_sys

import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.decorators.GridTexture;

class GridTextureImpl extends MultiTextureImplBase<GridTexture> implements ITextureImpl {

	public function new(texture:GridTexture) {
		super(texture);
	}
}

#end
