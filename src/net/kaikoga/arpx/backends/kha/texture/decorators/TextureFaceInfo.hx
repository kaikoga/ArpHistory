package net.kaikoga.arpx.backends.kha.texture.decorators;

#if arp_backend_kha

import kha.Image;
import kha.FastFloat;
import net.kaikoga.arpx.texture.Texture;

class TextureFaceInfo {

	private var source:Texture;
	public var sx(default, null):FastFloat;
	public var sy(default, null):FastFloat;
	public var sw(default, null):FastFloat;
	public var sh(default, null):FastFloat;

	private var _data:Image;
	public var data(get, never):Image;
	private function get_data():Image {
		if (this._data != null) return this._data;
		return this._data = this.source.trim(this.sx, this.sy, this.sw, this.sh);
	}

	public function new(source:Texture, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat) {
		this._data = source.image();
		if (sx == this._data.width && sh == this._data.height) {
		} else {
			this._data = null;
			this.sx = sx;
			this.sy = sy;
			this.sw = sw;
			this.sh = sh;
			this.source = source;
		}
	}

	public function dispose():Void this.data.unload();
}

#end
