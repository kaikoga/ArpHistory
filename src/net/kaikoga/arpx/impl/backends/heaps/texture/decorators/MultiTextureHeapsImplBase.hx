package net.kaikoga.arpx.impl.backends.heaps.texture.decorators;

#if arp_backend_heaps

import h2d.Tile;
import net.kaikoga.arpx.structs.IArpParamsRead;
import net.kaikoga.arpx.texture.decorators.MultiTexture;

class MultiTextureHeapsImplBase<T:MultiTexture> extends TextureHeapsImplBase implements ITextureHeapsImpl {

	private var texture:T;

	private var indexesByFaces:Map<String, Int>;
	private var faces:Array<Tile>;

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

	inline private function pushFaceInfo(tile:Tile, sx:Float, sy:Float, sw:Float, sh:Float):Void {
		this.faces.push(tile.sub(Std.int(sx), Std.int(sy), Std.int(sw), Std.int(sh)));
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
				this.texture.arpDomain.log("texture", 'MultiTextureHeapsImplBase.getFaceIndex(): Face name not found in: ${this.texture.arpSlot}:$params');
			}
		}

		try {
			var dIndex:Null<Int> = params.getInt("index");
			if (dIndex != null) index += dIndex;
		} catch (d:String) {
			this.texture.arpDomain.log("texture", 'MultiTextureHeapsImplBase.getFaceIndex(): Illegal index: ${this.texture.arpSlot}:$params');
		}

		return index;
	}

	public function getTile(params:IArpParamsRead = null):Tile {
		return this.faces[this.getFaceIndex(params)];
	}
}

#end
