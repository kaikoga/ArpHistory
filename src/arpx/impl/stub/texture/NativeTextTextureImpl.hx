package arpx.impl.stub.texture;

#if arp_display_backend_stub

import arpx.impl.stub.texture.decorators.MultiTextureImplBase;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> {

	public function new(texture:NativeTextTexture) {
		super(texture);
	}
}

#end
