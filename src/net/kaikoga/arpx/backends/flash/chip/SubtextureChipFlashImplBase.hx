package net.kaikoga.arpx.backends.flash.chip;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.flash.geom.ITransform;
import net.kaikoga.arpx.chip.SubtextureChip;
import net.kaikoga.arpx.texture.Texture;

@:generic @:remove
class SubtextureChipFlashImplBase<T:SubtextureChip> extends ArpObjectImplBase implements IChipFlashImpl {

	private var chip:T;

	private var sourceBitmap:BitmapData = null;
	private var indexesByFaces:Map<String, Int>;
	private var faces:Array<FaceInfo>;

	public function new(chip:T) {
		super();
		this.chip = chip;
		this.indexesByFaces = new Map();
		this.faces = [];
	}

	override public function arpHeatDown():Bool {
		for (face in this.faces) face.dispose();
		this.faces = [];
		this.indexesByFaces = new Map();
		return true;
	}

	inline private function nextFaceName(face:String):Void {
		this.indexesByFaces[face] = this.faces.length;
	}

	inline private function pushFaceInfo(source:Texture, bound:Rectangle):Void {
		this.faces.push(new FaceInfo(source, bound));
	}

	private function getFaceIndex(params:IArpParamsRead = null):Int {
		var index:Int = 0;

		if (params == null) {
			// face unset, use chip index = 0 as default
			return index;
		}

		var face:String = params.getAsString("face");
		if (face != null) {
			if (this.indexesByFaces.exists(face)) {
				index = this.indexesByFaces.get(face);
			} else {
				this.chip.arpDomain.log("gridchip", 'SubtextureChipFlashImplBase.getFaceIndex(): Chip name not found in: ${this.chip.arpSlot}:$params');
			}
		}

		try {
			var dIndex:Null<Int> = params.getInt("index");
			if (dIndex != null) index += dIndex;
		} catch (d:String) {
			this.chip.arpDomain.log("gridchip", 'SubtextureChipFlashImplBase.getFaceIndex(): Illegal index: ${this.chip.arpSlot}:$params');
		}

		return index;
	}

	private var _workRect:Rectangle = new Rectangle();
	private var _workMatrix:Matrix = new Matrix();

	public function copyChip(bitmapData:BitmapData, transform:ITransform, params:IArpParamsRead = null):Void {
		if (this.chip.arpSlot.heat < ArpHeat.Warm) {
			this.chip.arpDomain.log("gridchip", 'GridChip.copyChip(): Chip not warm: ${this}:$params');
			this.chip.arpDomain.heatLater(this.chip.arpSlot);
			return;
		}

		var index:Int = getFaceIndex(params);
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
			var colorTransform:ColorTransform = null;
			if (params.getBool("tint")) {
				var ra:Null<Float> = params.getFloat("redMultiplier", 1.0);
				var ga:Null<Float> = params.getFloat("greenMultiplier", 1.0);
				var ba:Null<Float> = params.getFloat("blueMultiplier", 1.0);
				var aa:Null<Float> = params.getFloat("alphaMultiplier", 1.0);
				var rb:Null<Float> = params.getFloat("redOffset", 0.0);
				var gb:Null<Float> = params.getFloat("greenOffset", 0.0);
				var bb:Null<Float> = params.getFloat("blueOffset", 0.0);
				var ab:Null<Float> = params.getFloat("alphaOffset", 0.0);
				colorTransform = new ColorTransform(ra, ga, ba, aa, rb, gb, bb, ab);
			}
			var blendMode:BlendMode = cast params.getAsString("blendMode");
			bitmapData.draw(faceInfo.data, transform.toMatrix(), colorTransform, blendMode);
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

#end
