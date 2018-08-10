package arpx.impl.sys.texture;

#if arp_display_backend_sys

import arpx.impl.cross.texture.ITextureImpl;
import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> implements ITextureImpl {

	public function new(texture:NativeTextTexture) {
		super(texture);
	}
}

#end
