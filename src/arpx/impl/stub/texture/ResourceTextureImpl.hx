package arpx.impl.stub.texture;

#if arp_display_backend_stub

import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}
}

#end
