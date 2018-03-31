package net.kaikoga.arpx.backends.kha.chip;

#if arp_backend_kha

import kha.math.Vector2;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Image;
import kha.FastFloat;
import flash.display.BitmapData;
import net.kaikoga.arp.domain.ArpHeat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.backends.kha.math.ITransform;
import net.kaikoga.arpx.chip.SubtextureChip;
import net.kaikoga.arpx.texture.Texture;

@:generic @:remove
class SubtextureChipKhaImplBase<T:SubtextureChip> extends ArpObjectImplBase implements IChipKhaImpl {

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

	inline private function pushFaceInfo(source:Texture, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat):Void {
		this.faces.push(new FaceInfo(source, sx, sy, sw, sh));
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
				this.chip.arpDomain.log("gridchip", 'SubtextureChipKhaImplBase.getFaceIndex(): Chip name not found in: ${this.chip.arpSlot}:$params');
			}
		}

		try {
			var dIndex:Null<Int> = params.getInt("index");
			if (dIndex != null) index += dIndex;
		} catch (d:String) {
			this.chip.arpDomain.log("gridchip", 'SubtextureChipKhaImplBase.getFaceIndex(): Illegal index: ${this.chip.arpSlot}:$params');
		}

		return index;
	}

	public function copyChip(g2:Graphics, transform:ITransform, params:IArpParamsRead = null):Void {
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

		var pt:Vector2 = transform.asPoint();
		if (pt != null) {
			g2.drawSubImage(this.chip.texture.image(), pt.x, pt.y, faceInfo.sx, faceInfo.sy, faceInfo.sw, faceInfo.sh);
		} else {
			/*
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
			*/
			g2.pushTransformation(FastMatrix3.fromMatrix3(transform.asMatrix()));
			g2.drawSubImage(this.chip.texture.image(), 0, 0, faceInfo.sx, faceInfo.sy, faceInfo.sw, faceInfo.sh);
			g2.popTransformation();
		}
	}
}

private class FaceInfo {

	private var source:Texture;
	public var sx(default, null):FastFloat;
	public var sy(default, null):FastFloat;
	public var sw(default, null):FastFloat;
	public var sh(default, null):FastFloat;

	private var _data:Image;
	public var data(get, never):Image;
	private function get_data():Image {
		if (this._data != null) return this._data;
		return this._data = this.source.trim(this.sx, this.sy, this.sw, this.sh);
	}

	public function new(source:Texture, sx:FastFloat, sy:FastFloat, sw:FastFloat, sh:FastFloat) {
		this.source = source;
		this.sx = sx;
		this.sy = sy;
		this.sw = sw;
		this.sh = sh;
	}

	public function dispose():Void this.data.unload();
}

#end
