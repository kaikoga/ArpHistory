package net.kaikoga.arpx.backends.kha.mortal;

#if arp_backend_kha

import kha.math.Vector2;
import kha.graphics2.Graphics;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.backends.kha.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.mortal.TileMapMortal;

class TileMapMortalKhaImpl extends ArpObjectImplBase implements IMortalKhaImpl {

	private var mortal:TileMapMortal;
	private var renderer:TileMapRenderer;

	public function new(mortal:TileMapMortal) {
		super();
		this.mortal = mortal;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copySelf(g2:Graphics, transform:ITransform):Void {
		if (this.mortal.visible) {
			var pt:Vector2 = transform.asPoint();
			if (pt == null) {
				//Do nothing. not supported.
				throw "TileMapMortalKhaImpl.copySelf(): scaling TileMap is currently not supported";
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
			this.renderer.copyArea(g2, gridX, gridY, gridWidth, gridHeight, Std.int(this.mortal.position.x + pt.x), Std.int(this.mortal.position.y + pt.y));
		}
	}
}

#end
