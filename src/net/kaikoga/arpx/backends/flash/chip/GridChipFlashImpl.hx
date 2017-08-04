package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arp.domain.ArpHeat;
import flash.geom.Point;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arpx.chip.GridChip;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import flash.display.BitmapData;

class GridChipFlashImpl extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:GridChip;

	public function new(chip:GridChip) {
		super();
		this.chip = chip;
	}

	private var sourceBitmap:BitmapData = null;
	private var indexesByFaces:Map<String, Int>;
	private var bounds:Array<Rectangle>;
	private var trimmedBitmaps:Map<Int, BitmapData>;

	override public function arpHeatUp():Bool {
		if (this.sourceBitmap != null) {
			return true;
		}
		this.sourceBitmap = this.chip.texture.bitmapData();
		this.indexesByFaces = new Map();
		this.bounds = [];
		this.trimmedBitmaps = new Map();
		if (this.chip.chipWidth == 0) {
			this.chip.chipWidth = this.chip.texture.width;
		}
		if (this.chip.chipHeight == 0) {
			this.chip.chipHeight = this.chip.texture.height;
		}

		var faces:Array<String>;
		var isVertical:Bool;
		if (this.chip.faceList != null) {
			faces = this.chip.faceList.toArray();
			isVertical = this.chip.faceList.isVertical;
		} else {
			faces = [""];
			isVertical = false;
		}
		var index:Int = 0;
		var x:Int = 0;
		var y:Int = 0;
		for (face in faces) {
			this.indexesByFaces[face] = index;
			for (dir in 0...this.chip.dirs) {
				this.bounds[index++] = new Rectangle(x, y, this.chip.chipWidth, this.chip.chipHeight);
				if (isVertical) {
					y += this.chip.chipHeight;
					if (y >= this.chip.texture.height) {
						y = 0;
						x += this.chip.chipWidth;
					}
				} else {
					x += this.chip.chipWidth;
					if (x >= this.chip.texture.width) {
						x = 0;
						y += this.chip.chipHeight;
					}
				}
			}
		}
		return true;
	}

	override public function arpHeatDown():Bool {
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
					this.trimmedBitmaps.set(index, this.chip.texture.trim(bound));
				} else {
					this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
				}
			}
			return result;
		}
		return null;
	}

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		var face:String = (params != null) ? params.get("face") : null;
		var dir:ArpDirection = (params != null) ? cast (params.get("dir"), ArpDirection) : null;
		var index:Int;
		if (params.hasKey("index")) {
			index = params.get("index");
		} else if (face != null) {
			if (this.indexesByFaces.exists(face)) {
				index = this.indexesByFaces[face];
			} else {
				index = 0;
				this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip name not found in: ${this}:$params');
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
			var bounds:Rectangle = this.bounds[index];
			if (bounds != null) {
				bitmapData.copyPixels(this.sourceBitmap, bounds, pt, null, null, this.chip.texture.hasAlpha);
			}
		} else {
			var bitmap:BitmapData = this.getTrimmedBitmap(index);
			if (bitmap != null) {
				bitmapData.draw(bitmap, transform.toMatrix(), transform.colorTransform, transform.blendMode);
			}
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
