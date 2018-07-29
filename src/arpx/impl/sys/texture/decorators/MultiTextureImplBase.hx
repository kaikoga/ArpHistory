package arpx.impl.sys.texture.decorators;

#if arp_display_backend_sys

import arpx.texture.decorators.MultiTexture;

class MultiTextureImplBase<T:MultiTexture> extends TextureImplBase implements ITextureImpl {

	private var texture:T;

	public function new(texture:T) {
		super();
		this.texture = texture;
	}
}

#end
