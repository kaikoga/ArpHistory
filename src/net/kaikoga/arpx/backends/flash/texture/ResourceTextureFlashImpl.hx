package net.kaikoga.arpx.backends.flash.texture;

import flash.geom.Rectangle;
import flash.geom.Point;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import flash.display.Bitmap;
import flash.events.IOErrorEvent;
import flash.events.Event;
import haxe.io.Bytes;
import flash.display.Loader;
import haxe.Resource;
import net.kaikoga.arpx.texture.ResourceTexture;
import flash.display.BitmapData;

class ResourceTextureFlashImpl extends ArpObjectImplBase implements ITextureFlashImpl {

	private var texture:ResourceTexture;
	private var loader:Loader;
	private var value:BitmapData;

	public var width(get, never):Int;
	private function get_width():Int return this.value.width;
	public var height(get, never):Int;
	private function get_height():Int return this.value.height;

	public function new(texture:ResourceTexture) {
		super();
		this.texture = texture;
	}

	override public function arpHeatUp():Bool {
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

	override public function arpHeatDown():Bool {
		this.loader = null;
		this.value = null;
		return true;
	}

	public function bitmapData():BitmapData {
		return this.value;
	}

	private static var nullPoint:Point = new Point(0, 0);
	public function trim(bound:Rectangle):BitmapData {
		var result = new BitmapData(Std.int(bound.width), Std.int(bound.height), true, 0x00000000);
		result.copyPixels(this.bitmapData(), bound, nullPoint);
		return result;
	}
}


