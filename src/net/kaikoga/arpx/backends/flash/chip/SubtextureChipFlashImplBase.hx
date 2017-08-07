package net.kaikoga.arpx.backends.flash.chip;

import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.ArpDirection;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.SubtextureChip;
import net.kaikoga.arpx.texture.Texture;

@:generic @:remove
class SubtextureChipFlashImplBase<T:SubtextureChip> extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:T;

	public function new(chip:T) {
		super();
		this.chip = chip;
		this.indexesByFaces = new Map();
		this.faces = [];
	}

	private var sourceBitmap:BitmapData = null;
	private var indexesByFaces:Map<String, Int>;
	private var faces:Array<FaceInfo>;

	private function pushChipFace(source:Texture, bound:Rectangle):Void {
		this.faces.push(new FaceInfo(source, bound));
	}

	override public function arpHeatDown():Bool {
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

		var face:String = (params != null) ? params.get("face") : null;
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

		var faceInfo:FaceInfo = this.faces[index];
		if (faceInfo == null) {
			this.chip.arpDomain.log("gridchip", 'GridChip.getTrimmedBitmap(): Chip index out of range: ${this}:$index');
			return;
		}

		var pt:Point = transform.asPoint();
		if (pt != null) {
			bitmapData.copyPixels(this.chip.texture.bitmapData(), faceInfo.bound, pt, null, null, this.chip.texture.hasAlpha);
		} else {
			bitmapData.draw(faceInfo.data, transform.toMatrix(), transform.colorTransform, transform.blendMode);
		}
	}
}

private class FaceInfo {

	private var source:Texture;
	public var bound(default, null):Rectangle;

	private var _data:BitmapData;
	public var data(get, never):BitmapData;
	private function get_data():BitmapData {
		if (this._data != null) return this._data;
		return this._data = this.source.trim(this.bound);
	}

	public function new(source:Texture, bound:Rectangle) {
		this.source = source;
		this.bound = bound;
	}

	public function dispose():Void this.data.dispose();
}
