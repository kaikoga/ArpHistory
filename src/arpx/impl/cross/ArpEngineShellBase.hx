package arpx.impl.cross;

import arpx.ArpEngineShellBufferMode;
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
	private var bufferMode:ArpEngineShellBufferMode;
	private var clearColor:UInt;

	private dynamic function _start():Void return;
	private dynamic function _rawTick(timeslice:Float):Void return;
	private dynamic function _firstTick(timeslice:Float):Void return;
	private dynamic function _tick(timeslice:Float):Void return;
	private dynamic function _render(context:RenderContext):Void return;

	public function new(domain:ArpDomain, initParams:ArpEngineParams) {
		this.domain = domain;

		this.width = initParams.shellBuffer.width;
		this.height = initParams.shellBuffer.height;
		this.scaleX = initParams.shellBuffer.scaleX;
		this.scaleY = initParams.shellBuffer.scaleY;
		this.bufferMode = initParams.shellBuffer.bufferMode;
		this.clearColor = initParams.shellBuffer.clearColor24;
		this.domain.tick.push(this.onDomainFirstTick);
		this._start = initParams.events.start;
		this._rawTick = initParams.events.rawTick;
		this._firstTick = initParams.events.firstTick;
		this._tick = initParams.events.tick;
		this._render = initParams.events.render;
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
