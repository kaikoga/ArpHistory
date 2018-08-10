package arpx.impl.flash.texture.decorators;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import arpx.texture.Texture;

class TextureFaceInfo {

	private var source:Texture;
	public var bound(default, null):Rectangle;

	private var _data:BitmapData;
	public var data(get, never):BitmapData;
	private function get_data():BitmapData {
		if (this._data != null) return this._data;

		var result = new BitmapData(Std.int(bound.width), Std.int(bound.height), true, 0x00000000);
		result.copyPixels(source.bitmapData(), bound, nullPoint);
		return this._data = result;
	}

	private static var nullPoint:Point = new Point(0, 0);

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

#end
