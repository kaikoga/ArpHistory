package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.flash.display.DisplayContext;
import net.kaikoga.arpx.backends.flash.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.chip.TileMapChip;

class TileMapChipFlashImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TileMapChip;
	private var renderer:TileMapRenderer;

	public function new(chip:TileMapChip) {
		super();
		this.chip = chip;
		this.renderer = new TileMapRenderer(null, null);
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:Point = context.transform.asPoint();
		if (pt == null) {
			//Do nothing. not supported.
			throw "TileMapChipFlashImpl.render(): scaling TileMap is currently not supported";
		}
		this.renderer.tileMap = this.chip.tileMap;
		this.renderer.chip = this.chip.chip;
		var chipWidth:Int = this.renderer.chip.chipWidth;
		var chipHeight:Int = this.renderer.chip.chipHeight;
		var gridX:Int = Math.floor(-pt.x / chipWidth);
		var gridY:Int = Math.floor(-pt.y / chipHeight);
		var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + context.bitmapData.width) / chipWidth);
		var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + context.bitmapData.height) / chipHeight);
		this.renderer.copyArea(context.bitmapData, gridX, gridY, gridWidth, gridHeight, Std.int(pt.x), Std.int(pt.y));
	}
}

#end
