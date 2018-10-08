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

	public function new(domain:ArpDomain, params:ArpEngineParams) {
		this.domain = domain;

		this.width = params.shellBuffer.width;
		this.height = params.shellBuffer.height;
		if (params.shellBuffer.scaleX != null) this.scaleX = params.shellBuffer.scaleX;
		if (params.shellBuffer.scaleY != null) this.scaleY = params.shellBuffer.scaleY;
		this.bufferMode = if (params.shellBuffer.bufferMode != null) params.shellBuffer.bufferMode else ArpEngineShellBufferMode.Logical;
		this.clearColor = params.shellBuffer.clearColor | 0xff000000;
		this.domain.tick.push(this.onDomainFirstTick);
		if (params.events.start != null) this._start = params.events.start;
		if (params.events.rawTick != null) this._rawTick = params.events.rawTick;
		if (params.events.firstTick != null) this._firstTick = params.events.firstTick;
		if (params.events.tick != null) this._tick = params.events.tick;
		if (params.events.render != null) this._render = params.events.render;
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
