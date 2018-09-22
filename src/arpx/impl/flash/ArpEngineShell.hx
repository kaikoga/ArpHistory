package arpx.impl.flash;

#if arp_display_backend_flash

import flash.geom.Matrix;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.ArpEngineShellBase;
import arpx.impl.cross.structs.ArpTransform;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.events.Event;

class ArpEngineShell extends ArpEngineShellBase {

	public function new(params:ArpEngineParams) {
		super(params);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onFirstFrame);
	}

	private function onEnterFrame(event:Event):Void {
		this.domainRawTick(60 / Lib.current.stage.frameRate);
		doRender(this.displayContext);
	}

	private function onFirstFrame(event:Event):Void {
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, this.onFirstFrame);
		this._start();
	}

	override private function createDisplayContext():DisplayContext {
#if true
		// canvas scaling
		var bitmapData:BitmapData = new BitmapData(this.width, this.height, true, this.clearColor);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		bitmap.transform.matrix = new Matrix(scaleX, 0, 0, scaleY, 0, 0);
		Lib.current.addChild(bitmap);
		return new DisplayContext(bitmapData, new ArpTransform(), this.clearColor);
#else
		// logical scaling
		var bitmapData:BitmapData = new BitmapData(Math.ceil(this.width * this.scaleX), Math.ceil(this.height * this.scaleY), true, this.clearColor);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, true);
		bitmap.transform.matrix = new Matrix();
		Lib.current.addChild(bitmap);
		return new DisplayContext(bitmapData, new ArpTransform().reset(scaleX, 0, 0, scaleY, 0, 0), this.clearColor);
#end
	}
}

#end
