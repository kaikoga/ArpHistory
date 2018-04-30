package net.kaikoga.arpx;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arpx.geom.APoint;

#if arp_backend_flash
import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.events.Event;
#elseif arp_backend_heaps
import hxd.App;
#end

typedef ArpEngineParams = {
	var domain:ArpDomain;
	var width:Int;
	var height:Int;
	var clearColor:UInt;
	@:optional var start:Void->Void;
	@:optional var rawTick:Float->Void;
	@:optional var firstTick:Float->Void;
	@:optional var tick:Float->Void;
}

class ArpEngine
	#if arp_backend_heaps extends App #end
{
	public var domain(default, null):ArpDomain;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var clearColor(default, null):UInt;
	private dynamic function _start():Void return;
	private dynamic function _rawTick(timeslice:Float):Void return;
	private dynamic function _firstTick(timeslice:Float):Void return;
	private dynamic function _tick(timeslice:Float):Void return;

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
#if arp_backend_flash
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this._start();
#elseif arp_backend_heaps
		super();
#end
	}

#if arp_backend_flash
	private function onEnterFrame(event:Event):Void this.domainRawTick(60 / Lib.current.stage.frameRate);
#elseif arp_backend_heaps
	override function init() this._start();
	override function update(dt:Float):Void this.domainRawTick(dt * 60);
#end

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

	public function createDisplayContext():DisplayContext {
#if arp_backend_flash
		var bitmapData:BitmapData = new BitmapData(this.width, this.height, true, this.clearColor);
		var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.NEVER, false);
		Lib.current.addChild(bitmap);
		return new DisplayContext(bitmapData, new APoint(), this.clearColor);
#elseif arp_backend_heaps
		return new DisplayContext(this.s2d, this.width, this.height, new APoint());
#end
	}
}
