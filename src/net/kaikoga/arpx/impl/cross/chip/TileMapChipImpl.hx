package net.kaikoga.arpx.impl.cross.chip;

import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.chip.TileMapChip;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.PointImpl;
import net.kaikoga.arpx.impl.ArpObjectImplBase;
import net.kaikoga.arpx.impl.cross.chip.IChipImpl;
import net.kaikoga.arpx.impl.cross.tilemap.legacy.TileMapRenderer;

class TileMapChipImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:TileMapChip;
	private var renderer:TileMapRenderer;

	public function new(chip:TileMapChip) {
		super();
		this.chip = chip;
		this.renderer = new TileMapRenderer(null, null);
	}

	private var _workPt:PointImpl = new PointImpl();
	public function render(context:DisplayContext, params:IArpParamsRead = null):Void {
		var pt:PointImpl = context.transform.asPoint(_workPt);
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
		var gridWidth:Int = Math.ceil((-pt.x - gridX * chipWidth + context.width) / chipWidth);
		var gridHeight:Int = Math.ceil((-pt.y - gridY * chipHeight + context.height) / chipHeight);
		this.renderer.copyArea(context, gridX, gridY, gridWidth, gridHeight, Std.int(pt.x), Std.int(pt.y));
	}
}