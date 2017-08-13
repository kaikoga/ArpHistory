package net.kaikoga.arpx.backends.flash.tileMap.legacy;

import net.kaikoga.arpx.tileMap.TileMap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.kaikoga.arpx.chip.Chip;

class TileMapView {

	public var bitmapData(default, null):BitmapData;
	public var scrollX(get, set):Int;
	public var scrollY(get, set):Int;

	private var renderer:TileMapRenderer;

	public function dispose():Void {
		this.bitmapData.dispose();
	}

	private var _rect:Rectangle;
	private var _point:Point;

	private var _scrollX:Int = 0;

	private function get_scrollX():Int {
		return this._scrollX;
	}

	private function set_scrollX(value:Int):Int {
		this.scrollTo(value, this._scrollY);
		return value;
	}

	private var _scrollY:Int = 0;

	private function get_scrollY():Int {
		return this._scrollY;
	}

	private function set_scrollY(value:Int):Int {
		this.scrollTo(this._scrollX, value);
		return value;
	}

	private var width:Int;
	private var height:Int;
	private var gridWidth:Int;
	private var gridHeight:Int;

	public function new(tileMap:TileMap, chip:Chip, width:Int, height:Int) {
		if (tileMap == null || chip == null) {
			throw "TileMapView.constructor(): Required argument is null.";
		}
		this.renderer = new TileMapRenderer(tileMap, chip);
		this.bitmapData = new BitmapData(width, height);
		this.width = width;
		this.height = height;
		this.gridWidth = Math.ceil(width / chip.chipWidth);
		this.gridHeight = Math.ceil(height / chip.chipHeight);
		this._rect = new Rectangle(0, 0, width, height);
		this._point = new Point(0, 0);
	}

	public function drawSelf(bitmapData:BitmapData, mergeAlpha:Bool = false):Void {
		bitmapData.copyPixels(this.bitmapData, this._rect, this._point, null, null, mergeAlpha);
	}

	public function scrollTo(x:Int, y:Int, dirty:Bool = false):Void {
		this.bitmapData.lock();
		var chipWidth:Int = this.renderer.chip.chipWidth;
		var chipHeight:Int = this.renderer.chip.chipHeight;
		var offsetGridX:Int = Math.floor(x / chipWidth);
		var offsetGridY:Int = Math.floor(y / chipHeight);
		if (dirty) {
			this.renderer.copyArea(this.bitmapData, offsetGridX, offsetGridY, this.gridWidth + 1, this.gridHeight + 1, -x, -y);
		}
		else {
			var dx:Int = this._scrollX - x;
			var dy:Int = this._scrollY - y;
			this.bitmapData.scroll(dx, dy);
			if (dx != 0) {
				var cleanGridLeft:Int = offsetGridX;
				var cleanGridRight:Int = offsetGridX + this.gridWidth;
				var dirtyGridWidth:Int = Math.ceil(Math.abs(dx / chipWidth)) + 1;
				var dirtyGridLeft:Int = ((dx < 0)) ? cleanGridRight - dirtyGridWidth + 1 : cleanGridLeft;
				this.renderer.copyArea(this.bitmapData, dirtyGridLeft, offsetGridY, dirtyGridWidth, this.gridHeight + 1, -x, -y);
			}
			if (dy != 0) {
				var cleanGridTop:Int = offsetGridY;
				var cleanGridBottom:Int = offsetGridY + this.gridHeight;
				var dirtyGridHeight:Int = Math.ceil(Math.abs(dy / chipHeight)) + 1;
				var dirtyGridTop:Int = ((dy < 0)) ? cleanGridBottom - dirtyGridHeight + 1 : cleanGridTop;
				this.renderer.copyArea(this.bitmapData, offsetGridX, dirtyGridTop, this.gridWidth + 1, dirtyGridHeight, -x, -y);
			}
		}
		this._scrollX = x;
		this._scrollY = y;
		this.bitmapData.unlock();
	}

	public function refresh(dirty:Bool = false):Void {
		this.scrollTo(this._scrollX, this._scrollY, true);
	}
}
