package arpx.impl.flash.texture;

#if arp_display_backend_flash

import flash.display.BitmapData;
import flash.geom.Point;
import arpx.impl.cross.geom.RectImpl;

class TextureFaceData {

	public var width(get, null):Int;
	inline private function get_width():Int return Std.int(bound.width);
	public var height(get, null):Int;
	inline private function get_height():Int return Std.int(bound.height);

	public var source(default, null):BitmapData;
	public var bound(default, null):RectImpl;

	private var _trimmed:BitmapData;
	public var trimmed(get, never):BitmapData;
	private function get_trimmed():BitmapData {
		if (this._trimmed != null) return this._trimmed;

		var result = new BitmapData(Std.int(bound.width), Std.int(bound.height), true, 0x00000000);
		result.copyPixels(source, bound.raw, nullPoint);
		return this._trimmed = result;
	}

	private static var nullPoint:Point = new Point(0, 0);

	public function new(source:BitmapData, bound:RectImpl = null) {
		this.source = source;
		if (bound != null) {
			this.bound = bound;
		} else {
			this._trimmed = source;
		}
	}

	inline public function trim(x:Float, y:Float, w:Float, h:Float):TextureFaceData {
		return new TextureFaceData(this.source, RectImpl.alloc(x, y, w, h));
	}

	public function dispose():Void if (this._trimmed != null) this._trimmed.dispose();
}

#end
