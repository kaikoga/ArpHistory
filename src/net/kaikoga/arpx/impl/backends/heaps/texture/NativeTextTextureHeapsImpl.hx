package net.kaikoga.arpx.impl.backends.heaps.texture;

#if arp_backend_heaps

import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFormat;
import h2d.Tile;
import net.kaikoga.arp.structs.IArpParamsRead;
import net.kaikoga.arpx.impl.backends.heaps.texture.decorators.MultiTextureHeapsImplBase;
import net.kaikoga.arpx.texture.NativeTextTexture;

class NativeTextTextureHeapsImpl extends MultiTextureHeapsImplBase<NativeTextTexture> {

	private var tile:Tile;

	override private function get_width():Int return this.texture.fontSize;
	override private function get_height():Int return this.texture.fontSize;

	public function new(texture:NativeTextTexture) {
		super(texture);
	}

	override public function arpHeatUp():Bool {
		if (this.tile != null) return true;
		#if flash
		var textField:TextField = new TextField();
		textField.x = -2;
		textField.y = -2;
		textField.width = 24;
		textField.height = 24;
		textField.textColor = this.texture.color.value32 | 0xff000000;
		textField.defaultTextFormat = new TextFormat(this.texture.font, this.texture.fontSize);
		textField.text = "ス";
		var bitmapData:BitmapData = new BitmapData(32, 32, true, 0); // FIXME
		bitmapData.draw(textField);
		this.tile = Tile.fromBitmap(hxd.BitmapData.fromNative(bitmapData));
		#end
		for (char in this.texture.faceList.toArray()) {
			this.nextFaceName(char);
			this.pushFaceInfo(this.tile, 0, 0, 16, 16);
		}
		return true;
	}

	override public function arpHeatDown():Bool {
		this.tile.dispose();
		this.tile = null;
		return true;
	}

	override public function getFaceIndex(params:IArpParamsRead = null):Int return 0;
}

#end
