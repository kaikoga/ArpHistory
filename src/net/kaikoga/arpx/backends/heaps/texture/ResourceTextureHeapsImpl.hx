package net.kaikoga.arpx.backends.heaps.texture;

#if arp_backend_heaps

import haxe.io.Bytes;
import haxe.Resource;

import h2d.Tile;
import hxd.fs.FileEntry;
import hxd.fs.BytesFileSystem.BytesFileEntry;
import hxd.res.Image;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.texture.ResourceTexture;

class ResourceTextureHeapsImpl extends TextureHeapsImplBase implements ITextureHeapsImpl {

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

	public function getTile(params:IArpParamsRead = null):Tile {
		return this.value.sub(0, 0, this.texture.width, this.texture.height);
	}
}

#end
