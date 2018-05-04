package net.kaikoga.arpx.backends.flash.display;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.ITransform;

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
}

#end
