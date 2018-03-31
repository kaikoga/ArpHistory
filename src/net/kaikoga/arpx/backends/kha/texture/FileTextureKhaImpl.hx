package net.kaikoga.arpx.backends.kha.texture;

#if arp_backend_kha

import kha.FastFloat;
import kha.Image;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.kha.texture.decorators.TextureFaceInfo;
import net.kaikoga.arpx.texture.FileTexture;

class FileTextureKhaImpl extends TextureKhaImplBase implements ITextureKhaImpl {

	private var texture:FileTexture;
	private var value:Image;

	override private function get_width():Int return this.value.width;
	override private function get_height():Int return this.value.height;

	public function new(texture:FileTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUp():Bool {
		if (this.value != null) return true;

		// Assets.loadImage(texture.src, false, onLoadComplete);
		this.texture.arpDomain.waitFor(this.texture);
		return false;
	}

	private function onLoadComplete(image:Image):Void {
		this.value = image;
		this.texture.arpDomain.notifyFor(this.texture);
	}

	override public function arpHeatDown():Bool {
		this.value = null;
		return true;
	}

	public function image():Image {
		return this.value;
	}

	public function trim(sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Image {
		var result = Image.create(Std.int(sw), Std.int(sh));
		result.g2.drawImage(this.value, -sx, -sy);
		return result;
	}

	public function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo {
		return new TextureFaceInfo(this.texture, 0, 0, this.texture.width, this.texture.height);
	}
}

#end
