package arpx;

import arpx.impl.cross.display.RenderContext;

class ArpEngineEventParams {
	@:optional public var start:Void->Void = () -> {};

	@:optional public var rawTick:Float->Void = _ -> {};

	@:optional public var firstTick:Float->Void = _ -> {};

	@:optional public var tick:Float->Void = _ -> {};

	@:optional public var render:RenderContext->Void = _ -> {};

	public function new() return;
}

