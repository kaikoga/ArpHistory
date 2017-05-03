package net.kaikoga.arpx.backends.flash.mortal;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.tileMap.TileMapRenderer;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.mortal.TileMapMortal;
import flash.display.BitmapData;
import flash.geom.Point;

class TileMapMortalFlashImpl extends ArpObjectImplBase implements IMortalFlashImpl {

	private var mortal:TileMapMortal;
	private var renderer:TileMapRenderer;

	public function new(mortal:TileMapMortal) {
		super();
		this.mortal = mortal;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copySelf(bitmapData:BitmapData, transform:ITransform):Void {
		if (this.mortal.visible) {
			var pt:Point = transform.asPoint();
			if (pt == null) {
				//Do nothing. not supported.
				throw "TileMapMortalFlashImpl.copySelf(): scaling TileMap is currently not supported";
			}
			this.renderer.tileMap = this.mortal.tileMap;
			this.renderer.chip = this.mortal.chip;
			var chipWidth:Int = this.renderer.chip.chipWidth;
			var chipHeight:Int = this.renderer.chip.chipHeight;
			var gridX:Int = Math.floor(-pt.x / chipWidth);
			var gridY:Int = Math.floor(-pt.y / chipHeight);
			var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + bitmapData.width) / chipWidth);
			var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + bitmapData.height) / chipHeight);
			this.renderer.copyArea(bitmapData, gridX, gridY, gridWidth, gridHeight, Std.int(this.mortal.position.x + pt.x), Std.int(this.mortal.position.y + pt.y));
		}
	}
}


