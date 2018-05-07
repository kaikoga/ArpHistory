package net.kaikoga.arpx.hud;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.impl.cross.hud.IHudImpl;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;


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
