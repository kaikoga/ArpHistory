package arpx.impl.heaps;

#if arp_display_backend_heaps

import hxd.App;

import arp.domain.ArpDomain;
import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.geom.Transform;

class ArpEngineShell extends App {

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
		super();
	}

	override function init() this._start();
	override function update(dt:Float):Void this.domainRawTick(dt * 60);

	override public function render(e:h3d.Engine):Void {
		s3d.render(e);
		_render();
		s2d.render(e);
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
		this._displayContext = new DisplayContext(this.s2d, this.width, this.height, new Transform());
		return this._displayContext;
	}
}

#end
