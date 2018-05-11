package net.kaikoga.arpx.impl.backends.heaps.display;

#if arp_backend_heaps

import h2d.Tile;
import h2d.Sprite;
import h3d.Engine;
import net.kaikoga.arpx.display.DisplayContextBase;
import net.kaikoga.arpx.display.IDisplayContext;
import net.kaikoga.arpx.geom.AMatrix;
import net.kaikoga.arpx.geom.ITransform;

class DisplayContext extends DisplayContextBase implements IDisplayContext {

	public var buf(default, null):Sprite;
	private var _width:Int;
	public var width(get, null):Int;
	private function get_width():Int return _width;
	private var _height:Int;
	public var height(get, null):Int;
	private function get_height():Int return _height;

	private var renderContext:RenderContext;
	
	public function new(buf:Sprite, width:Int, height:Int, transform:ITransform = null, clearColor:UInt = 0) {
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

	public function fillRect(l:Int, t:Int, w:Int, h:Int, color:UInt):Void {
		var matrix:AMatrix = transform.concatTransform(new AMatrix(w, 0, 0, h, l, t)).asMatrix();
		var tile:Tile = Tile.fromColor(color);
		this.renderContext.renderTile(matrix, tile);
	}

	public function drawTile(tile:Tile):Void {
		var matrix:AMatrix = transform.concatTransform(new AMatrix(tile.width, 0, 0, tile.height, 0, 0)).asMatrix();
		this.renderContext.renderTile(matrix, tile);
	}

}

#end
