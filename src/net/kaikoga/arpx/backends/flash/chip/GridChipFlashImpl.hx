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
	private var faces:Array<FaceInfo<BitmapData>>;

	override public function arpHeatUp():Bool {
		if (this.sourceBitmap != null) {
			return true;
		}
		this.sourceBitmap = this.chip.texture.bitmapData();
		this.indexesByFaces = new Map();
		this.faces = [];

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
				this.faces.push(new FaceInfo(new Rectangle(x, y, chipWidth, chipHeight)));
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

	override public function arpHeatDown():Bool {
		if (this.sourceBitmap != null) {
			this.sourceBitmap.dispose();
			this.sourceBitmap = null;
		}
		for (face in this.faces) face.dispose();
		this.faces = [];
		return true;
	}

	private static var nullPoint:Point = new Point(0, 0);
	private function getTrimmedBitmap(index:Int):BitmapData {
		var face = this.faces[index];
		if (face == null) {
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			return null;
		}
		var result:BitmapData = face.data;
		if (result == null) {
			result = this.chip.texture.trim(face.bound);
			face.data = result;
		}
		return result;
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
		var faceInfo:FaceInfo<BitmapData> = this.faces[index];
		if (pt != null) {
			if (face != null) {
				bitmapData.copyPixels(this.sourceBitmap, faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
			}
		} else {
			var bitmap:BitmapData = this.getTrimmedBitmap(index);
			if (bitmap != null) {
				bitmapData.draw(bitmap, transform.toMatrix(), transform.colorTransform, transform.blendMode);
			}
		}
	}
}

private class FaceInfo<T:{ public function dispose():Void; }> {

	public var bound:Rectangle;
	public var data:T;

	public function FaceInfo(bound:Rectangle) {
		this.bound = bound;
	}

	public function dispose():Void this.data.dispose();
}
