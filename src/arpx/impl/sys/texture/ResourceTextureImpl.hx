package arpx.impl.sys.texture;

#if arp_display_backend_sys

import arpx.impl.cross.texture.TextureImplBase;
import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}
}

#end
