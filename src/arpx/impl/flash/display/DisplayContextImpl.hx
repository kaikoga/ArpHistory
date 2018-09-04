package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import arpx.impl.cross.display.DisplayContextBase;
import arpx.impl.cross.display.IDisplayContext;
import arpx.impl.cross.display.IRenderContext;
import arpx.impl.cross.geom.Transform;

class DisplayContextImpl extends DisplayContextBase implements IDisplayContext implements IRenderContext {

	public var bitmapData(default, null):BitmapData;

	public var width(get, never):Int;
	private function get_width():Int return bitmapData.width;
	public var height(get, never):Int;
	private function get_height():Int return bitmapData.height;

	public function new(bitmapData:BitmapData, transform:Transform = null, clearColor:UInt = 0xff000000) {
		super(transform, clearColor);
		this.bitmapData = bitmapData;
	}

	public function start():Void this.bitmapData.fillRect(this.bitmapData.rect, clearColor);
	public function display():Void return;

	private var _workRect:Rectangle = new Rectangle();
	inline public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var workRect:Rectangle = this._workRect;
		workRect.setTo(this.transform.raw.tx + l, this.transform.raw.ty + t, w, h);
		this.bitmapData.fillRect(workRect, color);
	}
}

#end
