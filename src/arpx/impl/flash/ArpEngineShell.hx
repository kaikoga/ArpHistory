package arpx.impl.flash;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.events.Event;

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;

class ArpEngineShell {

	public var domain(default, null):ArpDomain;

	private var width:Int;
	private var height:Int;
	private var clearColor:UInt;

	private dynamic function _start():Void return;
	private dynamic function _rawTick(timeslice:Float):Void return;
	private dynamic function _firstTick(timeslice:Float):Void return;
	private dynamic function _tick(timeslice:Float):Void return;
	private dynamic function _render():Void return;

	public function new(params:ArpEngineParams) {
		this.domain = params.domain;
		this.width = params.width;
		this.height = params.height;
		this.clearColor = params.clearColor | 0xff000000;
		this.domain.tick.push(this.onDomainFirstTick);
		if (params.start != null) this._start = params.start;
		if (params.rawTick != null) this._rawTick = params.rawTick;
		if (params.firstTick != null) this._firstTick = params.firstTick;
		if (params.tick != null) this._tick = params.tick;
		if (params.render != null) this._render = params.render;
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onFirstFrame);
	}

	private function onEnterFrame(event:Event):Void {
		this.domainRawTick(60 / Lib.current.stage.frameRate);
		this._render();
	}

	private function onFirstFrame(event:Event):Void {
		Lib.current.stage.removeEventListener(Event.ENTER_FRAME, this.onFirstFrame);
		this._start();
	}

	private function domainRawTick(timeslice:Float):Void {
		this.domain.rawTick.dispatch(timeslice);
		this._rawTick(timeslice);
	}

	private function onDomainFirstTick(timeslice:Float):Void {
		this.domain.tick.remove(this.onDomainFirstTick);
		this._firstTick(timeslice);
		this.domain.tick.push(this.onDomainTick);
	}

	private function onDomainTick(timeslice:Float):Void {
		this._tick(timeslice);
	}

	private var _displayContext:DisplayContext;

	public function createDisplayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		var bitmapData:BitmapData = new BitmapData(this.width, this.height, true, this.clearColor);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		Lib.current.addChild(bitmap);
		this._displayContext = new DisplayContext(bitmapData, new Transform(), this.clearColor);
		return this._displayContext;
	}
}

#end
