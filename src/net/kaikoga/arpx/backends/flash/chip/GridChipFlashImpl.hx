package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.ArpParams;
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
		var x:Int = 0;
		var y:Int = 0;
		for (face in this.chip.faceList.toArray()) {
			this.nextFaceName(face);
			for (dir in 0...this.chip.dirs) {
				this.pushFaceInfo(this.chip.texture, new Rectangle(x, y, chipWidth, chipHeight));
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

	override private function getFaceIndex(params:ArpParams = null):Int {
		if (params == null) {
			// face unset, use chip index = 0 as default
			return 0;
		}
		var index:Int = super.getFaceIndex(params);
		try {
			var dir:ArpDirection = params.getArpDirection("dir");
			index += ((dir != null) ? dir.toIndex(this.chip.dirs) : 0);
		} catch (d:Dynamic) {
			this.chip.arpDomain.log("gridchip", 'GridChip.getFaceIndex(): Illegal dir: $this:$params');
		}
		return index;
	}

}
