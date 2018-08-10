package arpx.impl.heaps.texture;

#if arp_display_backend_heaps

#if flash
import arpx.impl.heaps.texture.TextureFaceData;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextFormat;
import arpx.impl.flash.display.BitmapFont;
import arpx.impl.flash.display.BitmapFontDrawCursor;
#end

import h2d.Tile;
import hxd.Pixels.Flags;
import arpx.impl.cross.texture.decorators.MultiTextureImplBase;
import arpx.texture.NativeTextTexture;

class NativeTextTextureImpl extends MultiTextureImplBase<NativeTextTexture> implements ITextureImpl {

	private var tile:Tile;

	override private function get_width():Int return this.texture.fontSize;
	override private function get_height():Int return this.texture.fontSize;

	public function new(texture:NativeTextTexture) {
		super(texture);
	}

	override public function arpHeatUp():Bool {
		if (this.tile != null) return true;

		#if flash

		var textFormat:TextFormat = new TextFormat(this.texture.font, this.texture.fontSize);
		var bitmapFont:BitmapFont = new BitmapFont(textFormat, 0, 0, false);
		var bitmapData:BitmapData = new BitmapData(2048, 2048, true, 0); // FIXME
		this.tile = @:privateAccess new Tile(null, 0, 0, bitmapData.width, bitmapData.height);
		var cursor:BitmapFontDrawCursor = new BitmapFontDrawCursor(bitmapFont, bitmapData.width, bitmapData.height);
		var faceInfo:TextureFaceData = new TextureFaceData(this.tile);
		for (char in this.texture.faceList) {
			this.nextFaceName(char);
			var charCode:Int = char.charCodeAt(0);
			cursor.move(charCode);
			bitmapFont.drawChar(bitmapData, charCode, cursor.x, cursor.y);
			var bounds:Rectangle = bitmapFont.getBounds(charCode);
			this.pushFaceInfo(faceInfo.trim(cursor.x, cursor.y, bounds.width, bounds.height));
		}

		bitmapFont.dispose();
		this.tile = tileFromPremult(bitmapData);
		this.tile.getTexture().realloc = () -> { this.tile = null; this.arpHeatUp(); }

		for (face in this.faces) @:privateAccess face.tile.setTexture(this.tile.innerTex);

		#end

		return true;
	}

	override public function arpHeatDown():Bool {
		this.tile.dispose();
		this.tile = null;
		return true;
	}

	#if flash
	private static function tileFromPremult(bitmapData:BitmapData):Tile {
		var pixels = hxd.BitmapData.fromNative(bitmapData).getPixels();
		bitmapData.dispose();

		pixels.flags.set(Flags.AlphaPremultiplied);

		var tile:Tile = Tile.fromPixels(pixels);
		pixels.dispose();
		return tile;
	}
	#end
}

#end
