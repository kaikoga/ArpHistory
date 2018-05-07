package net.kaikoga.arpx.impl.backends.heaps.display;

#if arp_backend_heaps

import net.kaikoga.arpx.geom.APoint;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Sprite;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContext extends DisplayContextBase implements IDisplayContext {

	public var buf(default, null):Sprite;
	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	public function new(buf:Sprite, width:Int, height:Int, transform:ITransform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this.buf = buf;
		this._width = width;
		this._height = height;
	}

	public function start():Void this.buf.removeChildren();
	public function display():Void return;

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var pt:APoint = transform.asPoint();
		if (pt != null) {
			var tile:Tile = Tile.fromColor(color);
			var bitmap:Bitmap = new Bitmap(tile, buf);
			bitmap.x = pt.x + l;
			bitmap.y = pt.y + t;
			bitmap.scaleX = w;
			bitmap.scaleY = h;
		}
	}

}

#end
