package arpx.impl.cross.mortal;

import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.PointImpl;
import arpx.impl.ArpObjectImplBase;
import arpx.impl.cross.mortal.IMortalImpl;
import arpx.impl.cross.tilemap.legacy.TileMapRenderer;
import arpx.mortal.TileMapMortal;

class TileMapMortalImpl extends ArpObjectImplBase implements IMortalImpl {

	private var mortal:TileMapMortal;
	private var renderer:TileMapRenderer;

	public function new(mortal:TileMapMortal) {
		super();
		this.mortal = mortal;
		this.renderer = new TileMapRenderer(null, null);
	}

	private var _workPt:PointImpl = new PointImpl();
	public function render(context:DisplayContext):Void {
		if (this.mortal.visible) {
			var pt:PointImpl = context.transform.asPoint(_workPt);
			if (pt == null) {
				//Do nothing. not supported.
				throw "TileMapMortalFlashImpl.render(): scaling TileMap is currently not supported";
			}
			this.renderer.tileMap = this.mortal.tileMap;
			this.renderer.chip = this.mortal.chip;
			var chipWidth:Int = this.renderer.chip.chipWidth;
			var chipHeight:Int = this.renderer.chip.chipHeight;
			var gridX:Int = Math.floor(-pt.x / chipWidth);
			var gridY:Int = Math.floor(-pt.y / chipHeight);
			var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + context.width) / chipWidth);
			var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + context.height) / chipHeight);
			this.renderer.copyArea(context, gridX, gridY, gridWidth, gridHeight, Std.int(this.mortal.position.x + pt.x), Std.int(this.mortal.position.y + pt.y));
		}
	}
}
