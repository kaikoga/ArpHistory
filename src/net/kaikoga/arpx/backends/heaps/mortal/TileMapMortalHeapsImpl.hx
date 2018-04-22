package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import h3d.col.Point;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.heaps.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.mortal.TileMapMortal;

class TileMapMortalHeapsImpl extends ArpObjectImplBase implements IMortalHeapsImpl {

	private var mortal:TileMapMortal;
	private var renderer:TileMapRenderer;

	public function new(mortal:TileMapMortal) {
		super();
		this.mortal = mortal;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copySelf(context:DisplayContext):Void {
		if (this.mortal.visible) {
			var pt:Point = context.transform.asPoint();
			if (pt == null) {
				//Do nothing. not supported.
				throw "TileMapMortalHeapsImpl.copySelf(): scaling TileMap is currently not supported";
			}
			this.renderer.tileMap = this.mortal.tileMap;
			this.renderer.chip = this.mortal.chip;
			var chipWidth:Int = this.renderer.chip.chipWidth;
			var chipHeight:Int = this.renderer.chip.chipHeight;
			var gridX:Int = Math.floor(-pt.x / chipWidth);
			var gridY:Int = Math.floor(-pt.y / chipHeight);
			var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + context.width) / chipWidth);
			var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + context.height) / chipHeight);
			this.renderer.copyArea(context.buf, gridX, gridY, gridWidth, gridHeight, Std.int(this.mortal.position.x + pt.x), Std.int(this.mortal.position.y + pt.y));
		}
	}
}

#end
