package arpx.impl.backends.flash.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextFormat;
import arpx.impl.backends.flash.texture.decorators.MultiTextureFlashImplBase;
import arpx.impl.backends.flash.display.BitmapFont;
import arpx.impl.backends.flash.display.BitmapFontDrawCursor;
import arpx.structs.IArpParamsRead;
import arpx.texture.NativeTextTexture;

class NativeTextTextureFlashImpl extends MultiTextureFlashImplBase<NativeTextTexture> {

	private var _bitmapData:BitmapData;

	override private function get_width():Int return this.texture.fontSize;
	override private function get_height():Int return this.texture.fontSize;

	public function new(texture:NativeTextTexture) {
		super(texture);
	}

	override public function arpHeatUp():Bool {
		if (this.faces.length > 0) return true;

		var textFormat:TextFormat = new TextFormat(this.texture.font, this.texture.fontSize);
		var bitmapFont:BitmapFont = new BitmapFont(textFormat, 0, 0, false);
		this._bitmapData = new BitmapData(2048, 2048, true, 0xffff00ff); // FIXME

		var cursor:BitmapFontDrawCursor = new BitmapFontDrawCursor(bitmapFont, this._bitmapData.width, this._bitmapData.height);
		for (char in this.texture.faceList) {
			this.nextFaceName(char);
			var charCode:Int = char.charCodeAt(0);
			cursor.move(charCode);
			bitmapFont.drawChar(this._bitmapData, charCode, cursor.x, cursor.y);
			var bounds:Rectangle = bitmapFont.getBounds(charCode).clone();
			bounds.x = cursor.x;
			bounds.y = cursor.y;
			this.pushFaceInfo(bounds);
		}
		bitmapFont.dispose();
		return true;
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int return try super.getFaceIndex(params) catch (e:Dynamic) 0;

	override public function arpHeatDown():Bool {
		this._bitmapData.dispose();
		this._bitmapData = null;
		return true;
	}

	override public function bitmapData():BitmapData return this._bitmapData;
}

#end
