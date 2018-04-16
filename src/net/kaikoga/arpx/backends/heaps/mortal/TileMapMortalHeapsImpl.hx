package net.kaikoga.arpx.backends.heaps.mortal;

#if arp_backend_heaps

import h2d.Sprite;
import h3d.col.Point;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.heaps.geom.ITransform;
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

	public function copySelf(buf:Sprite, transform:ITransform):Void {
		if (this.mortal.visible) {
			var pt:Point = transform.asPoint();
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
			// FIXME
			var gridWidth:Int = 8; // Math.ceil((-pt.x - gridX * chipWidth + g2.width) / chipWidth);
			var gridHeight:Int = 8; // Math.ceil((-pt.y - gridY * chipHeight + g2.height) / chipHeight);
			this.renderer.copyArea(buf, gridX, gridY, gridWidth, gridHeight, Std.int(this.mortal.position.x + pt.x), Std.int(this.mortal.position.y + pt.y));
		}
	}
}

#end
