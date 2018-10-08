package arpx;

import arpx.impl.cross.display.RenderContext;
import arpx.ArpEngineShellBufferMode;
class ArpEngineParams {
	public var shellBufferParams:ArpEngineShellBufferParams;
	public var events:ArpEngineEventParams;

	public function new() {
		this.shellBufferParams = new ArpEngineShellBufferParams();
		this.events = new ArpEngineEventParams();
	}

	public function shellBuffer(width:Int, height:Int, clearColor:UInt = 0xff000000):ArpEngineParams {
		this.shellBufferParams.width = width;
		this.shellBufferParams.height = height;
		this.shellBufferParams.clearColor = clearColor;
		return this;
	}

	public function shellBufferScaling(scaleX:Float, scaleY:Null<Float> = null, bufferMode:Null<ArpEngineShellBufferMode> = null):ArpEngineParams {
		this.shellBufferParams.scaleX = scaleX;
		this.shellBufferParams.scaleY = if (scaleY == null) scaleX else scaleY;
		this.shellBufferParams.bufferMode = if (bufferMode == null) ArpEngineShellBufferMode.Automatic else bufferMode;
		return this;
	}

	//** Called once when renderContext is available. domain may not be ready.
	public function start(start:Void->Void):ArpEngineParams {
		this.events.start = start;
		return this;
	}

	//** Called every frame after renderContext is available. domain may not be ready.
	public function rawTick(rawTick:Float->Void):ArpEngineParams {
		this.events.rawTick = rawTick;
		return this;
	}

	//** Called once when renderContext and domain is ready.
	public function firstTick(firstTick:Float->Void):ArpEngineParams {
		this.events.firstTick = firstTick;
		return this;
	}

	//** Called every frame after renderContext and domain is ready.
	public function tick(tick:Float->Void):ArpEngineParams {
		this.events.tick = tick;
		return this;
	}

	//** Rendering is requested from backend. renderContext is ready, but domain may not be ready.
	public function render(render:RenderContext->Void):ArpEngineParams {
		this.events.render = render;
		return this;
	}
}
