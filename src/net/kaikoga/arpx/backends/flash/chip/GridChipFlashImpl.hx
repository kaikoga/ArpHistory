package net.kaikoga.arpx.backends.flash.chip;

import flash.geom.Rectangle;
import net.kaikoga.arpx.chip.GridChip;

class GridChipFlashImpl extends SubtextureChipFlashImplBase<GridChip> implements IChipFlashImpl {

	public function new(chip:GridChip) {
		super(chip);
	}

	override public function arpHeatUp():Bool {
		super.arpHeatUp();

		if (this.faces.length > 0) return true;
		var chipTextureWidth:Int = this.chip.texture.width;
		var chipTextureHeight:Int = this.chip.texture.height;

		var chipWidth:Int = this.chip.chipWidth;
		if (chipWidth == 0) chipWidth = chipTextureWidth;
		var chipHeight:Int = this.chip.chipHeight;
		if (chipHeight == 0) chipHeight = chipTextureHeight;

		var isVertical:Bool = this.chip.faceList.isVertical;
		var index:Int = 0;
		var x:Int = 0;
		var y:Int = 0;
		for (face in this.chip.faceList.toArray()) {
			this.indexesByFaces[face] = index;
			for (dir in 0...this.chip.dirs) {
				this.pushChipFace(this.chip.texture, new Rectangle(x, y, chipWidth, chipHeight));
				index++;
				if (isVertical) {
					y += chipHeight;
					if (y >= chipTextureHeight) {
						y = 0;
						x += chipWidth;
					}
				} else {
					x += chipWidth;
					if (x >= chipTextureWidth) {
						x = 0;
						y += chipHeight;
					}
				}
			}
		}
		return true;
	}
}
