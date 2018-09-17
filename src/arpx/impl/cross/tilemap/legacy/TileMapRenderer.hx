package arpx.impl.cross.tilemap.legacy;

import arpx.chip.Chip;
import arpx.impl.cross.display.RenderContext;
import arpx.impl.cross.structs.ArpTransform;
import arpx.structs.ArpParams;
import arpx.tileMap.TileMap;

class TileMapRenderer {

	public var chip:Chip;
	public var tileMap:TileMap;

	public function new(tileMap:TileMap, chip:Chip) {
		this.tileMap = tileMap;
		this.chip = chip;
	}

	private static var _workParams:ArpParams = new ArpParams();
	public function copyArea(context:RenderContext, gridX:Int, gridY:Int, gridWidth:Int, gridHeight:Int, offsetX:Int, offsetY:Int):Void {
		var chipWidth:Int = this.chip.chipWidth;
		var chipHeight:Int = this.chip.chipHeight;
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
		var transform:ArpTransform = context.dupTransform();
		transform.setXY(destLeft, destTop);
		for (i in gridX...gridRight) {
			var transform:ArpTransform = context.dupTransform();
			for (j in gridY...gridBottom) {
				params.set("index", this.tileMap.getTileIndexAtGrid(i, j));
				this.chip.render(context, params);
				transform.prependXY(0, chipHeight);
			}
			context.popTransform();
			context.transform.prependXY(chipWidth, 0);
		}
		context.popTransform();
	}
}
