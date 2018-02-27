package net.kaikoga.arpx.backends.kha.texture.decorators;

#if arp_backend_kha

import flash.display.BitmapData;
import flash.geom.Rectangle;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.texture.decorators.MultiTexture;

class MultiTextureKhaImplBase<T:MultiTexture> extends TextureKhaImplBase implements ITextureKhaImpl {

	private var texture:T;

	private var sourceBitmap:BitmapData = null;
	private var indexesByFaces:Map<String, Int>;
	private var faces:Array<TextureFaceInfo>;

	public function new(texture:T) {
		super();
		this.texture = texture;
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

	inline private function pushFaceInfo(bound:Rectangle):Void {
		this.faces.push(new TextureFaceInfo(this.texture, bound));
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int {
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
				this.texture.arpDomain.log("texture", 'MultiTextureKhaImplBase.getFaceIndex(): Face name not found in: ${this.texture.arpSlot}:$params');
			}
		}

		try {
			var dIndex:Null<Int> = params.getInt("index");
			if (dIndex != null) index += dIndex;
		} catch (d:String) {
			this.texture.arpDomain.log("texture", 'MultiTextureKhaImplBase.getFaceIndex(): Illegal index: ${this.texture.arpSlot}:$params');
		}

		return index;
	}

	public function bitmapData():BitmapData return this.texture.texture.bitmapData();
	public function trim(bound:Rectangle):BitmapData return this.texture.texture.trim(bound);

	public function getFaceInfo(params:IArpParamsRead = null):TextureFaceInfo {
		return this.faces[this.getFaceIndex(params)];
	}
}

#end
