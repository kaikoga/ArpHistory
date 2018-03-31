package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.math.Vector2;
import kha.graphics2.Graphics;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.backends.kha.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.chip.TileMapChip;

class TileMapChipKhaImpl extends ArpObjectImplBase implements IChipKhaImpl {

	private var chip:TileMapChip;
	private var renderer:TileMapRenderer;

	public function new(chip:TileMapChip) {
		super();
		this.chip = chip;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
		var pt:Vector2 = transform.asPoint();
		if (pt == null) {
			//Do nothing. not supported.
			throw "TileMapChipKhaImpl.copySelf(): scaling TileMap is currently not supported";
		}
		this.renderer.tileMap = this.chip.tileMap;
		this.renderer.chip = this.chip.chip;
		var chipWidth:Int = this.renderer.chip.chipWidth;
		var chipHeight:Int = this.renderer.chip.chipHeight;
		var gridX:Int = Math.floor(-pt.x / chipWidth);
		var gridY:Int = Math.floor(-pt.y / chipHeight);
		// FIXME
		var gridWidth:Int = 8; // Math.ceil((-pt.x - gridX * chipWidth + bitmapData.width) / chipWidth);
		var gridHeight:Int = 8; // Math.ceil((-pt.y - gridY * chipHeight + bitmapData.height) / chipHeight);
		this.renderer.copyArea(g2, gridX, gridY, gridWidth, gridHeight, Std.int(pt.x), Std.int(pt.y));
	}
}

#end
