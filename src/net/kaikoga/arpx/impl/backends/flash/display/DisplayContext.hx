package net.kaikoga.arpx.impl.backends.flash.display;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.ITransform;
import net.kaikoga.arpx.geom.PointImpl;

class DisplayContext extends DisplayContextBase implements IDisplayContext {

	public var bitmapData:BitmapData;

	public var width(get, never):Int;
	private function get_width():Int return bitmapData.width;
	public var height(get, never):Int;
	private function get_height():Int return bitmapData.height;

	public function new(bitmapData:BitmapData, transform:ITransform = null, clearColor:UInt = 0xff000000) {
		super(transform, clearColor);
		this.bitmapData = bitmapData;
	}

	public function start():Void this.bitmapData.fillRect(this.bitmapData.rect, clearColor);
	public function display():Void return;


	private var _workRect:Rectangle = new Rectangle();
	inline public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var pt:PointImpl = this.transform.asPoint();
		var workRect:Rectangle = this._workRect;
		workRect.setTo(pt.x + l, pt.y + t, w, h);
		this.bitmapData.fillRect(workRect, color);
	}
}

#end
