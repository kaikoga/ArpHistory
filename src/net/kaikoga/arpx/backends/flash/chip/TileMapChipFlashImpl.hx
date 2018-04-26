package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.chip.TileMapChip;
import net.kaikoga.arpx.geom.ITransform;

class TileMapChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:TileMapChip;
	private var renderer:TileMapRenderer;

	public function new(chip:TileMapChip) {
		super();
		this.chip = chip;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		var pt:Point = transform.asPoint();
		if (pt == null) {
			//Do nothing. not supported.
			throw "TileMapChipFlashImpl.copySelf(): scaling TileMap is currently not supported";
		}
		this.renderer.tileMap = this.chip.tileMap;
		this.renderer.chip = this.chip.chip;
		var chipWidth:Int = this.renderer.chip.chipWidth;
		var chipHeight:Int = this.renderer.chip.chipHeight;
		var gridX:Int = Math.floor(-pt.x / chipWidth);
		var gridY:Int = Math.floor(-pt.y / chipHeight);
		var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + bitmapData.width) / chipWidth);
		var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + bitmapData.height) / chipHeight);
		this.renderer.copyArea(bitmapData, gridX, gridY, gridWidth, gridHeight, Std.int(pt.x), Std.int(pt.y));
	}
}

#end
