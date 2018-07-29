package arpx.impl.sys.texture;

#if arp_display_backend_sys

import arpx.impl.sys.texture.decorators.MultiTextureImplBase;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> {

	public function new(texture:NativeTextTexture) {
		super(texture);
	}
}

#end
