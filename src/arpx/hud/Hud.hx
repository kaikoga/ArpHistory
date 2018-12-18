package arpx.hud;

import arp.domain.IArpObject;
import arp.task.ITickable;
import arpx.driver.Driver;
import arpx.impl.cross.hud.IHudImpl;
import arpx.input.focus.IFocusNode;
import arpx.input.Input;
import arpx.structs.ArpParams;
import arpx.structs.ArpPosition;


@:arpType("hud", "null")
class Hud implements IArpObject implements ITickable implements IFocusNode<Hud> implements IHudImpl {
	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;

	@:arpImpl private var arpImpl:IHudImpl;

	public function new() return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function findFocus(other:Null<Hud>):Null<Hud> {
		return null;
	}

	public function updateFocus(target:Null<Hud>):Void {
		return;
	}

	public function interact(input:Input):Bool {
		return false;
	}
}