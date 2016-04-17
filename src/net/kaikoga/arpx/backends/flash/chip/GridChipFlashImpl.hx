package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arp.domain.ArpHeat;
import flash.geom.Point;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arpx.chip.GridChip;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;

class GridChipFlashImpl implements IChipFlashImpl {

	private var chip:GridChip;

	public function new(chip:GridChip) {
		this.chip = chip;
	}

	private var sourceBitmap:BitmapData = null;
	private var indexesByFaces:Map<String, Int>;
	private var bounds:Array<Rectangle>;
	private var trimmedBitmaps:Map<Int, BitmapData>;

	public function heatUp():Bool {
		if (this.sourceBitmap != null) {
			return true;
		}
		this.sourceBitmap = this.chip.texture.bitmapData();
		this.indexesByFaces = new Map();
		this.bounds = [];
		this.trimmedBitmaps = new Map();
		if (this.chip.chipWidth == 0) {
			this.chip.chipWidth = this.sourceBitmap.width;
		}
		if (this.chip.chipHeight == 0) {
			this.chip.chipHeight = this.sourceBitmap.height;
		}

		var faces:Array<String>;
		var isVertical:Bool;
		if (this.chip.faceList != null) {
			faces = this.chip.faceList.toArray();
			isVertical = this.chip.faceList.isVertical;
		} else {
			faces = [];
			isVertical = false;
		}
		var index:Int = 0;
		var c:Int = faces.length;
		var x:Int = 0;
		var y:Int = 0;
		if (c == 0) {
			faces.push("");
			c++;
		}
		//c *= this.dirs;
		for (i in 0...c) {
			var face:String = faces[i];
			this.indexesByFaces[face] = index;
			for (dir in 0...this.chip.dirs) {
				this.bounds[index++] = new Rectangle(x, y, this.chip.chipWidth, this.chip.chipHeight);
				if (isVertical) {
					y += this.chip.chipHeight;
					if (y >= this.sourceBitmap.height) {
						y = 0;
						x += this.chip.chipWidth;
					}
				} else {
					x += this.chip.chipWidth;
					if (x >= this.sourceBitmap.width) {
						x = 0;
						y += this.chip.chipHeight;
					}
				}
			}
		}
		return true;
	}

	public function heatDown():Bool {
		if (this.sourceBitmap == null) {
			return true;
		}
		this.sourceBitmap.dispose();
		this.sourceBitmap = null;
		this.bounds = null;
		for (bitmapData in this.trimmedBitmaps) {
			bitmapData.dispose();
		}
		this.trimmedBitmaps = null;
		return true;
	}

	private static var nullPoint:Point = new Point(0, 0);
	private function getTrimmedBitmap(index:Int):BitmapData {
		if (index >= 0 && index < this.bounds.length) {
			var result:BitmapData = null;
			if (this.trimmedBitmaps.exists(index)) {
				result = this.trimmedBitmaps.get(index);
			}
			if (result == null) {
				var bound:Rectangle = this.bounds[index];
				if (bound != null) {
					result = new BitmapData(Std.int(bound.width), Std.int(bound.height), true, 0x00000000);
					result.copyPixels(this.sourceBitmap, bound, nullPoint);
					this.trimmedBitmaps.set(index, result);
				} else {
					this.chip.arpDomain().log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
				}
			}
			return result;
		}
		return null;
	}

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		if (this.chip.arpSlot().heat < ArpHeat.Warm) {
			this.chip.arpDomain().log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain().heatLater(this.chip.arpSlot());
			return;
		}

		var face:String = (params != null) ? params.get("face") : null;
		var dir:ArpDirection = (params != null) ? cast (params.get("dir"), ArpDirection) : null;
		var index:Int;
		if (params.get("index") != null) {
			index = params.get("index");
		} else if (face != null) {
			if (this.indexesByFaces.exists(face)) {
				index = this.indexesByFaces[face];
			} else {
				index = 0;
				this.chip.arpDomain().log("gridchip", 'GridChip.copyChip(): Chip name not found in: ${this}:$params');
			}
			index += ((dir != null) ? dir.toIndex(this.chip.dirs) : 0);
		} else {
			//use chip index = 0 as default
			index = (dir != null) ? dir.toIndex(this.chip.dirs) : 0;
		}

		if (this.chip.baseX | this.chip.baseY != 0) {
			transform = transform.concatXY(-this.chip.baseX, -this.chip.baseY);
		}
		var pt:Point = transform.asPoint();
		if (pt != null) {
			bitmapData.copyPixels(this.sourceBitmap, this.bounds[index], pt, null, null, this.chip.texture.hasAlpha);
		} else {
			var bitmap:BitmapData = this.getTrimmedBitmap(index);
			bitmapData.draw(bitmap, transform.toMatrix(), transform.colorTransform, transform.blendMode);
		}

	}

	/*
	public function exportChipSprite(params:ArpParams = null):AChipSprite {
		var result:GridChipSprite = new GridChipSprite(this);
		result.refresh(params);
		return result;
	}
	*/

}
