package net.kaikoga.arpx.backends.flash.texture.decorators;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arpx.texture.Texture;

class TextureFaceInfo {

	private var source:Texture;
	public var bound(default, null):Rectangle;

	private var _data:BitmapData;
	public var data(get, never):BitmapData;
	private function get_data():BitmapData {
		if (this._data != null) return this._data;
		return this._data = this.source.trim(this.bound);
	}

	public function new(source:Texture, bound:Rectangle) {
		this.source = source;
		if (bound != null) {
			this.bound = bound;
		} else {
			this._data = source.bitmapData();
		}
	}

	public function dispose():Void this.data.dispose();
}
