package arpx.impl.stub.texture;

#if arp_display_backend_stub

import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return new TextureFaceData();
	}
}

#end
