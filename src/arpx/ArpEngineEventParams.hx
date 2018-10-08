package arpx;

import arpx.impl.cross.display.RenderContext;

@:structInit
class ArpEngineEventParams {
	//** Called once when renderContext is available. domain may not be ready.
	@:optional public var start:Void->Void = () -> {};

	//** Called every frame after renderContext is available. domain may not be ready.
	@:optional public var rawTick:Float->Void = _ -> {};

	//** Called once when renderContext and domain is ready.
	@:optional public var firstTick:Float->Void = _ -> {};

	//** Called every frame after renderContext and domain is ready.
	@:optional public var tick:Float->Void = _ -> {};

	//** Rendering is requested from backend. renderContext is ready, but domain may not be ready.
	@:optional public var render:RenderContext->Void = _ -> {};
}
