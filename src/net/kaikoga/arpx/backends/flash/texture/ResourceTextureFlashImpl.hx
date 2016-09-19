package net.kaikoga.arpx.backends.flash.texture;

import flash.display.Bitmap;
import flash.events.IOErrorEvent;
import flash.events.Event;
import haxe.io.Bytes;
import flash.display.Loader;
import haxe.Resource;
import net.kaikoga.arpx.texture.ResourceTexture;
import flash.display.BitmapData;

class ResourceTextureFlashImpl implements ITextureFlashImpl {

	private var texture:ResourceTexture;
	private var loader:Loader;
	private var value:BitmapData;

	public function new(texture:ResourceTexture) {
		this.texture = texture;
	}

	public function heatUp():Bool {
		if (this.value != null) return true;

		if (this.loader == null) {
			var bytes:Bytes = Resource.getBytes(texture.src);
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
			this.loader.loadBytes(bytes.getData());
		}
		this.texture.arpDomain.waitFor(this.texture);
		return false;
	}

	private function onLoadError(event:IOErrorEvent):Void {
		this.texture.arpDomain.notifyFor(this.texture);
	}

	private function onLoadComplete(event:Event):Void {
		this.value = cast(this.loader.content, Bitmap).bitmapData;
		this.texture.arpDomain.notifyFor(this.texture);
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


