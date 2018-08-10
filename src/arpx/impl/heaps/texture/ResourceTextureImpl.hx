package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import arpx.impl.cross.texture.decorators.TextureFaceInfo;
import h2d.Tile;
import haxe.io.Bytes;
import haxe.Resource;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.fs.FileEntry;
import hxd.res.Image;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.ResourceTexture;

class ResourceTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:ResourceTexture;
	private var value:Tile;

	override private function get_width():Int return this.value.width;
	override private function get_height():Int return this.value.height;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		var bytes:Bytes = Resource.getBytes(texture.src);
		var fileEntry:FileEntry = new BytesFileEntry("", bytes);
		// 	this.texture.arpDomain.waitFor(this.texture);
		// 	return false;
		// }

		// private function onLoadComplete(image:Image):Void {
		this.value = new Image(fileEntry).toTile();
		// this.texture.arpDomain.notifyFor(this.texture);
		return true;
	}

	override public function arpHeatDown():Bool {
		this.value = null;
		return true;
	}

	public function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo {
		return new TextureFaceInfo(this.value).trim(0, 0, this.texture.width, this.texture.height);
	}
}

#end
