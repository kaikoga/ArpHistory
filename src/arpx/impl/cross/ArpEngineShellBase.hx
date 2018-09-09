package arpx.impl.cross;

import arpx.impl.cross.display.DisplayContext;
import arpx.impl.cross.display.RenderContext;
import arp.domain.ArpDomain;

class ArpEngineShellBase {

	public var domain(default, null):ArpDomain;

	public var displayContext(get, never):DisplayContext;
	private var _displayContext:DisplayContext;
	public function get_displayContext():DisplayContext {
		if (this._displayContext != null) return this._displayContext;
		return this._displayContext = createDisplayContext();
	}

	private var width:Int;
	private var height:Int;
	private var scaleX:Float = 1.0;
	private var scaleY:Float = 1.0;
	private var clearColor:UInt;

	private dynamic function _start():Void return;
	private dynamic function _rawTick(timeslice:Float):Void return;
	private dynamic function _firstTick(timeslice:Float):Void return;
	private dynamic function _tick(timeslice:Float):Void return;
	private dynamic function _render(context:RenderContext):Void return;

	public function new(params:ArpEngineParams) {
		this.domain = params.domain;
		this.width = params.width;
		this.height = params.height;
		if (params.scaleX != null) this.scaleX = params.scaleX;
		if (params.scaleY != null) this.scaleY = params.scaleY;
		this.clearColor = params.clearColor | 0xff000000;
		this.domain.tick.push(this.onDomainFirstTick);
		if (params.start != null) this._start = params.start;
		if (params.rawTick != null) this._rawTick = params.rawTick;
		if (params.firstTick != null) this._firstTick = params.firstTick;
		if (params.tick != null) this._tick = params.tick;
		if (params.render != null) this._render = params.render;
	}

	private function createDisplayContext():DisplayContext return null;

	private function domainRawTick(timeslice:Float):Void {
		this.domain.rawTick.dispatch(timeslice);
		this._rawTick(timeslice);
	}

	private function doRender(displayContext:DisplayContext):Void {
		var renderContext:RenderContext = displayContext.renderContext();
		this._render(renderContext);
		renderContext.display();
	}

	private function onDomainFirstTick(timeslice:Float):Void {
		this.domain.tick.remove(this.onDomainFirstTick);
		this._firstTick(timeslice);
		this.domain.tick.push(this.onDomainTick);
	}

	private function onDomainTick(timeslice:Float):Void {
		this._tick(timeslice);
	}
}
