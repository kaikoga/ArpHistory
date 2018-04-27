package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h3d.col.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.backends.heaps.tileMap.legacy.TileMapRenderer;
import net.kaikoga.arpx.chip.TileMapChip;

class TileMapChipHeapsImpl extends ArpObjectImplBase implements IChipImpl {

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
			throw "TileMapChipHeapsImpl.render(): scaling TileMap is currently not supported";
		}
		this.renderer.tileMap = this.chip.tileMap;
		this.renderer.chip = this.chip.chip;
		var chipWidth:Int = this.renderer.chip.chipWidth;
		var chipHeight:Int = this.renderer.chip.chipHeight;
		var gridX:Int = Math.floor(-pt.x / chipWidth);
		var gridY:Int = Math.floor(-pt.y / chipHeight);
		var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + context.width) / chipWidth);
		var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + context.height) / chipHeight);
		this.renderer.copyArea(context.buf, gridX, gridY, gridWidth, gridHeight, Std.int(pt.x), Std.int(pt.y));
	}
}

#end
