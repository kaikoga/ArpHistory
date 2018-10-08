package arpx;

import arpx.impl.cross.display.RenderContext;
import arpx.ArpEngineShellBufferMode;

class ArpEngineConfig {

	public var shellBufferParams(default, null):ArpEngineShellBufferParams;
	public var events(default, null):ArpEngineEventParams;

	public function new() {
		this.shellBufferParams = new ArpEngineShellBufferParams();
		this.events = new ArpEngineEventParams();
	}

	public function shellBuffer(width:Int, height:Int, clearColor:UInt = 0xff000000):ArpEngineConfig {
		this.shellBufferParams.width = width;
		this.shellBufferParams.height = height;
		this.shellBufferParams.clearColor = clearColor;
		return this;
	}

	public function shellBufferScaling(scaleX:Float, scaleY:Null<Float> = null, bufferMode:Null<ArpEngineShellBufferMode> = null):ArpEngineConfig {
		this.shellBufferParams.scaleX = scaleX;
		this.shellBufferParams.scaleY = if (scaleY == null) scaleX else scaleY;
		this.shellBufferParams.bufferMode = if (bufferMode == null) ArpEngineShellBufferMode.Automatic else bufferMode;
		return this;
	}

	//** Called once when renderContext is available. domain may not be ready.
	public function start(start:Void->Void):ArpEngineConfig {
		this.events.start = start;
		return this;
	}

	//** Called every frame after renderContext is available. domain may not be ready.
	public function rawTick(rawTick:Float->Void):ArpEngineConfig {
		this.events.rawTick = rawTick;
		return this;
	}

	//** Called once when renderContext and domain is ready.
	public function firstTick(firstTick:Float->Void):ArpEngineConfig {
		this.events.firstTick = firstTick;
		return this;
	}

	//** Called every frame after renderContext and domain is ready.
	public function tick(tick:Float->Void):ArpEngineConfig {
		this.events.tick = tick;
		return this;
	}

	//** Rendering is requested from backend. renderContext is ready, but domain may not be ready.
	public function render(render:RenderContext->Void):ArpEngineConfig {
		this.events.render = render;
		return this;
	}
}

class ArpEngineShellBufferParams {
	public var width:Int = 640;
	public var height:Int = 480;
	public var clearColor:UInt = 0xff000000;
	public var scaleX:Float = 1.0;
	public var scaleY:Float = 1.0;
	public var bufferMode:ArpEngineShellBufferMode = ArpEngineShellBufferMode.Automatic;

	public var clearColor24(get, never):UInt;
	private function get_clearColor24():UInt return clearColor | 0xff000000;

	public function new() return;
}

class ArpEngineEventParams {
	public var start:Void->Void = () -> {};
	public var rawTick:Float->Void = _ -> {};
	public var firstTick:Float->Void = _ -> {};
	public var tick:Float->Void = _ -> {};
	public var render:RenderContext->Void = _ -> {};
	public function new() return;
}
