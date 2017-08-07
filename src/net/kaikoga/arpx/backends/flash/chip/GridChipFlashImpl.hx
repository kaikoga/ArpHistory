package net.kaikoga.arpx.backends.flash.chip;

import net.kaikoga.arpx.texture.Texture;
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
	private var faces:Array<FaceInfo<BitmapData, Texture>>;

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
				this.faces.push(new FaceInfo(this.chip.texture, new Rectangle(x, y, chipWidth, chipHeight)));
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

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:ArpParams = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		var face:String = (params != null) ? cast (params.get("face"), String) : null;
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
		} else {
			// face unset, use chip index = 0 as default
			index = 0;
		}

		var dir:ArpDirection = (params != null) ? cast (params.get("dir"), ArpDirection) : null;
		index += ((dir != null) ? dir.toIndex(this.chip.dirs) : 0);

		if (this.chip.baseX | this.chip.baseY != 0) {
			transform = transform.concatXY(-this.chip.baseX, -this.chip.baseY);
		}

		var faceInfo:FaceInfo<BitmapData> = this.faces[index];
		if (faceInfo == null) {
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			return;
		}

		var pt:Point = transform.asPoint();
		if (pt != null) {
			bitmapData.copyPixels(this.sourceBitmap, faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
		} else {
			bitmapData.draw(faceInfo.data, transform.toMatrix(), transform.colorTransform, transform.blendMode);
		}
	}
}

@:generic @:remove
private class FaceInfo<T:{ public function dispose():Void; }, S:{ public function trim(bound:Rectangle):T; }> {

	private var source:S;
	private var bound:Rectangle;
	private var _data:T;
	public var data(get, never):T;
	private function get_data():T {
		if (this._data != null) return this._data;
		return this._data = this.source.trim();
	}

	public function FaceInfo(source:T, bound:Rectangle) {
		this.source = source;
		this.bound = bound;
	}

	public function dispose():Void this.data.dispose();
}
