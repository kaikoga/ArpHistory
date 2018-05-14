package net.kaikoga.arpx.impl.backends.heaps.display;

#if arp_backend_heaps

import h2d.Sprite;
import h2d.Tile;
import h3d.Engine;
import h3d.Matrix;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.Transform;

class DisplayContext extends DisplayContextBase implements IDisplayContext {

	public var buf(default, null):Sprite;
	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	private var renderContext:RenderContext;

	public function new(buf:Sprite, width:Int, height:Int, transform:Transform = null, clearColor:UInt = 0) {
		super(transform, clearColor);
		this.buf = buf;
		this._width = width;
		this._height = height;
		this.renderContext = new RenderContext(Engine.getCurrent());
	}

	public function start():Void {
		this.buf.removeChildren();
		this.renderContext.start();
	}
	public function display():Void this.renderContext.display();

	private var _workMatrix:Transform = new Transform();
	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var workMatrix:Transform = _workMatrix;
		workMatrix._11 = w;
		workMatrix._22 = h;
		workMatrix._41 = l;
		workMatrix._42 = t;
		var matrix:Matrix = dupTransform().appendTransform(workMatrix).asMatrix();
		var tile:Tile = Tile.fromColor(color);
		this.renderContext.renderTile(matrix, tile);
		popTransform();
	}

	public function drawTile(tile:Tile):Void {
		var workMatrix:Transform = _workMatrix;
		workMatrix._11 = tile.width;
		workMatrix._22 = tile.height;
		workMatrix._41 = 0;
		workMatrix._42 = 0;
		var matrix:Matrix = dupTransform().appendTransform(workMatrix).asMatrix();
		this.renderContext.renderTile(matrix, tile);
		popTransform();
	}

}

#end
