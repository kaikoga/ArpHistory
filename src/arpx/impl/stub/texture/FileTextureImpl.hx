package arpx.impl.stub.texture;

#if arp_display_backend_stub

import arpx.texture.FileTexture;

class FileTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:FileTexture;

	public function new(texture:FileTexture) {
		super();
		this.texture = texture;
	}
}

#end
