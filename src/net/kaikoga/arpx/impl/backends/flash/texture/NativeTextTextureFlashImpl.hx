package net.kaikoga.arpx.impl.backends.flash.texture;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.backends.flash.texture.decorators.MultiTextureFlashImplBase;
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

		var textField:TextField = new TextField();
		textField.x = -2;
		textField.y = -2;
		textField.width = 24;
		textField.height = 24;
		textField.textColor = this.texture.color.value32;
		textField.defaultTextFormat = new TextFormat(this.texture.font, this.texture.fontSize);
		textField.text = "ス";
		this._bitmapData = new BitmapData(2048, 2048, true, 0); // FIXME
		this._bitmapData.draw(textField);
		for (char in this.texture.faceList.toArray()) {
			this.nextFaceName(char);
			this.pushFaceInfo(new Rectangle(0, 0, 16, 16));
		}
		return true;
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int return 0;

	override public function arpHeatDown():Bool {
		this._bitmapData.dispose();
		this._bitmapData = null;
		return true;
	}

	override public function bitmapData():BitmapData return this._bitmapData;
	override public function trim(bound:Rectangle):BitmapData return this._bitmapData;
}

#end
