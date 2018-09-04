package arpx.impl.heaps.display;

#if arp_display_backend_heaps

import h2d.Sprite;
import h2d.Tile;
import h3d.Engine;
import h3d.Matrix;
import arpx.impl.cross.display.DisplayContextBase;
import arpx.impl.cross.display.IDisplayContext;
import arpx.impl.cross.display.IRenderContext;
import arpx.impl.cross.geom.Transform;

class DisplayContext extends DisplayContextBase implements IDisplayContext implements IRenderContext {

	public var buf(default, null):Sprite;
	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	private var renderer:RendererImpl;

	public function new(buf:Sprite, width:Int, height:Int, transform:Transform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this.buf = buf;
		this._width = width;
		this._height = height;
		this.renderer = new RendererImpl(Engine.getCurrent());
	}

	public function start():Void {
		this.buf.removeChildren();
		this.renderer.start();
	}
	public function display():Void this.renderer.display();

	private var _workMatrix:Transform = new Transform();
	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var _workTransform:Transform = _workMatrix;
		_workTransform.raw._11 = w;
		_workTransform.raw._22 = h;
		_workTransform.raw._41 = l;
		_workTransform.raw._42 = t;
		var matrix:Matrix = dupTransform().appendTransform(_workTransform).raw;
		var tile:Tile = Tile.fromColor(color);
		this.renderer.renderTile(matrix, tile);
		popTransform();
	}

	public function drawTile(tile:Tile, r:Float = 1., g:Float = 1., b:Float = 1., a:Float = 1.):Void {
		var _workTransform:Transform = _workMatrix;
		_workTransform.raw._11 = tile.width;
		_workTransform.raw._22 = tile.height;
		_workTransform.raw._41 = 0;
		_workTransform.raw._42 = 0;
		var matrix:Matrix = dupTransform().appendTransform(_workTransform).raw;
		this.renderer.renderTile(matrix, tile, r, g, b, a);
		popTransform();
	}

}

#end
