package net.kaikoga.arpx.screen.procs;

import net.kaikoga.arpx.proc.Proc;

@:arpType("proc", "screen.visible")
class ProcScreenVisible extends Proc {
	@:arpField public var screen:Screen;
	@:arpField public var visible:Bool;

	public function new() {
		super();
	}

	override public function execute():Void {
		screen.visible = visible;
	}
}
