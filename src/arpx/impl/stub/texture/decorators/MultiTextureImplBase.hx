package arpx.impl.stub.texture.decorators;

#if arp_display_backend_stub

import arpx.impl.cross.texture.TextureImplBase;
import arpx.texture.decorators.MultiTexture;

class MultiTextureImplBase<T:MultiTexture> extends TextureImplBase implements ITextureImpl {

	private var texture:T;

	public function new(texture:T) {
		super();
		this.texture = texture;
	}
}

#end
