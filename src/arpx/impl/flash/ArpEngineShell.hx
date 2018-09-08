package arpx.impl.flash;

#if arp_display_backend_flash

import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;
import arpx.impl.cross.ArpEngineShellBase;

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
		var bitmapData:BitmapData = new BitmapData(this.width, this.height, true, this.clearColor);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		Lib.current.addChild(bitmap);
		return new DisplayContext(bitmapData, new Transform(), this.clearColor);
	}
}

#end
