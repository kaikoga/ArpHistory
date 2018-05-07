package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arp.domain.IArpObject;

import net.kaikoga.arpx.impl.cross.screen.IScreenImpl;

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable implements IFocusNode<Input> implements IScreenImpl {
	@:arpField public var ticks:Bool = false;
	@:arpField public var visible:Bool = true;

	@:arpImpl private var arpImpl:IScreenImpl;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function findFocus(other:Null<Input>):Null<Input> {
		return null;
	}

	public function updateFocus(target:Null<Input>):Void {
	}
}
