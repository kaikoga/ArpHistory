package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

import arpx.impl.cross.texture.TextureFaceData;
import h2d.Tile;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.fs.FileEntry;
import hxd.res.Image;
import arpx.impl.cross.texture.TextureImplBase;
import arpx.structs.IArpParamsRead;
import arpx.texture.FileTexture;

class FileTextureImpl extends TextureImplBase implements ITextureImpl {

	private var texture:FileTexture;
	private var value:Tile;

	override private function get_width():Int return this.value.width;
	override private function get_height():Int return this.value.height;

	public function new(texture:FileTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		var fileEntry:FileEntry = new BytesFileEntry("", texture.file.bytes());
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

	public function getFaceData(params:IArpParamsRead = null):TextureFaceData {
		return new TextureFaceData(this.value).trim(0, 0, this.texture.width, this.texture.height);
	}
}

#end
