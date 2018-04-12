package net.kaikoga.arpx.backends.heaps.tileMap.legacy;

#if arp_backend_heaps

import h2d.Sprite;

import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.heaps.math.APoint;
import net.kaikoga.arpx.chip.Chip;
import net.kaikoga.arpx.tileMap.TileMap;

class TileMapRenderer {

	public var chip:Chip;
	public var tileMap:TileMap;

	public function new(tileMap:TileMap, chip:Chip) {
		this.tileMap = tileMap;
		this.chip = chip;
	}

	private static var _workPt:APoint = new APoint();
	private static var _workParams:ArpParams = new ArpParams();

	public function copyArea(buf:Sprite, gridX:Int, gridY:Int, gridWidth:Int, gridHeight:Int, offsetX:Int, offsetY:Int):Void {
		var chipWidth:Int = this.chip.chipWidth;
		var chipHeight:Int = this.chip.chipHeight;
		var pt:APoint = _workPt;
		var params:ArpParams = _workParams;
		var gridRight:Int = gridX + gridWidth;
		var gridBottom:Int = gridY + gridHeight;
		if (!this.tileMap.isInfinite) {
			var chipMapWidth:Int = this.tileMap.width;
			var chipMapHeight:Int = this.tileMap.height;
			if (gridX < 0) gridX = 0;
			if (gridY < 0) gridY = 0;
			if (gridRight > chipMapWidth) gridRight = chipMapWidth;
			if (gridBottom > chipMapHeight) gridBottom = chipMapHeight;
		}
		var destLeft:Int = offsetX + chipWidth * gridX;
		var destTop:Int = offsetY + chipHeight * gridY;
		pt.x = destLeft;
		for (i in gridX...gridRight) {
			pt.y = destTop;
			for (j in gridY...gridBottom) {
				params.set("index", this.tileMap.getTileIndexAtGrid(i, j));
				this.chip.copyChip(buf, pt, params);
				pt.y += chipHeight;
			}
			pt.x += chipWidth;
		}
	}
}

#end
