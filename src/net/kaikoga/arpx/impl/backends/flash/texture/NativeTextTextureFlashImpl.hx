package net.kaikoga.arpx.impl.backends.flash.texture;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextFormat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.backends.flash.texture.decorators.MultiTextureFlashImplBase;
import net.kaikoga.arpx.impl.targets.flash.display.BitmapFont;
import net.kaikoga.arpx.texture.NativeTextTexture;

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
		this._bitmapData = new BitmapData(32, 32, true, 0); // FIXME
		bitmapFont.drawChar(this._bitmapData, "ス".code, 0, 0);
		bitmapFont.drawChar(this._bitmapData, "タ".code, 0, 16);
		bitmapFont.drawChar(this._bitmapData, "ー".code, 16, 0);
		this.nextFaceName("ス");
		this.pushFaceInfo(new Rectangle(0, 0, 16, 16));
		this.nextFaceName("タ");
		this.pushFaceInfo(new Rectangle(0, 16, 16, 16));
		this.nextFaceName("ー");
		this.pushFaceInfo(new Rectangle(16, 0, 16, 16));
		/*
		for (char in this.texture.faceList.toArray()) {
			var charCode:Int = char.charCodeAt(0);
			this.nextFaceName(char);
			this.pushFaceInfo(bitmapFont.getBounds(charCode));
		}
		*/
		return true;
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int return try super.getFaceIndex(params) catch (e:Dynamic) 0;

	override public function arpHeatDown():Bool {
		this._bitmapData.dispose();
		this._bitmapData = null;
		return true;
	}

	override public function bitmapData():BitmapData return this._bitmapData;
	override public function trim(bound:Rectangle):BitmapData return this._bitmapData;
}

#end
