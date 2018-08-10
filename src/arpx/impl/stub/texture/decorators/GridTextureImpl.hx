package arpx.impl.stub.texture.decorators;

#if arp_display_backend_stub

import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.decorators.GridTexture;

class GridTextureImpl extends MultiTextureImplBase<GridTexture> implements ITextureImpl implements ITextureImpl {

	public function new(texture:GridTexture) {
		super(texture);
	}
}

#end
