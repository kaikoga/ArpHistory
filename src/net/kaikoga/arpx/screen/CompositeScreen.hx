package net.kaikoga.arpx.screen;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.backends.cross.screen.CompositeScreenImpl;
import net.kaikoga.arpx.input.Input;

@:arpType("screen", "composite")
class CompositeScreen extends Screen {
	@:arpBarrier @:arpField("screen") public var screens:IOmap<String, Screen>;

	@:arpImpl private var arpImpl:CompositeScreenImpl;

	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		return true;
	}

	override public function findFocus(other:Null<Input>):Null<Input> {
		for (screen in this.screens) other = screen.findFocus(other);
		return other;
	}

	override public function updateFocus(target:Null<Input>):Void {
		for (screen in this.screens) screen.updateFocus(target);
	}
}
