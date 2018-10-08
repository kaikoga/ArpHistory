package arpx;

import arpx.impl.cross.display.RenderContext;

typedef ArpEngineEventParams = {
	//** Called once when renderContext is available. domain may not be ready.
	@:optional var start:Void->Void;

	//** Called every frame after renderContext is available. domain may not be ready.
	@:optional var rawTick:Float->Void;

	//** Called once when renderContext and domain is ready.
	@:optional var firstTick:Float->Void;

	//** Called every frame after renderContext and domain is ready.
	@:optional var tick:Float->Void;

	//** Rendering is requested from backend. renderContext is ready, but domain may not be ready.
	@:optional var render:RenderContext->Void;
}
