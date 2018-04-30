package net.kaikoga.arpx.backends.heaps.chip;

#if arp_backend_heaps

import h2d.Bitmap;
import h2d.Tile;
import h3d.col.Point;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.cross.chip.IChipImpl;
import net.kaikoga.arpx.backends.heaps.display.DisplayContext;
import net.kaikoga.arpx.chip.RectChip;

class RectChipHeapsImpl extends ArpObjectImplBase implements IChipImpl {

	private var chip:RectChip;

	public function new(chip:RectChip) {
		super();
		this.chip = chip;
	}

	public function copyChip(context:DisplayContext, params:IArpParamsRead = null):Void {
		//TODO optimize
		var pt:Point = context.transform.asPoint();
		if (pt != null) {
			var tile:Tile = Tile.fromColor(chip.border.value32);
			var bitmap:Bitmap = new Bitmap(tile, context.buf);
			bitmap.x = pt.x - chip.baseX;
			bitmap.y = pt.y - chip.baseY;
			bitmap.scaleX = chip.chipWidth;
			bitmap.scaleY = chip.chipHeight;

			var tile:Tile = Tile.fromColor(chip.color.value32);
			var bitmap:Bitmap = new Bitmap(tile, context.buf);
			bitmap.x = pt.x - chip.baseX + 1;
			bitmap.y = pt.y - chip.baseY + 1;
			bitmap.scaleX = chip.chipWidth - 2;
			bitmap.scaleY = chip.chipHeight - 2;
		} else {
			/*
			var workMatrix:Matrix = _workMatrix;
			workMatrix.setTo(1, 0, 0, 1, -this.baseX, -this.baseY);
			workMatrix.concat(transform.toMatrix());
			bitmapData.draw(this.exportChipSprite(params), workMatrix, transform.colorTransform, transform.blendMode);
			*/
		}
	}
}

#end
