package net.kaikoga.arpx.backends.flash.texture;

import flash.display.Bitmap;
import flash.events.IOErrorEvent;
import flash.events.Event;
import haxe.io.Bytes;
import flash.display.Loader;
import net.kaikoga.arpx.texture.FileTexture;
import flash.display.BitmapData;

class FileTextureFlashImpl implements ITextureFlashImpl {

	private var texture:FileTexture;
	private var loader:Loader;
	private var value:BitmapData;

	public function new(texture:FileTexture) {
		this.texture = texture;
	}

	public function heatUp():Bool {
		if (this.value != null) return true;

		if (this.loader == null) {
			var bytes:Bytes = texture.file.bytes();
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
			this.loader.loadBytes(bytes.getData());
		}
		this.texture.arpDomain().waitFor(this.texture);
		return false;
	}

	private function onLoadError(event:IOErrorEvent):Void {
		this.texture.arpDomain().notifyFor(this.texture);
	}

	private function onLoadComplete(event:Event):Void {
		this.value = cast(this.loader.content, Bitmap).bitmapData;
		this.texture.arpDomain().notifyFor(this.texture);
	}

	public function heatDown():Bool {
		this.loader = null;
		this.value = null;
		return true;
	}

	public function bitmapData():BitmapData {
		return this.value;
	}
}


