package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.backends.flash.hud.IHudFlashImpl;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.IInputControl;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
#end

@:arpType("hud", "null")
class Hud implements IArpObject implements ITickable implements IFocusNode<IInputControl> implements IInputControl
#if (arp_backend_flash || arp_backend_openfl) implements IMortalFlashImpl #end
{
	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IHudFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
	}

	public function tick(timeslice:Float):Bool {
		return true;
	}

	public function findFocus(other:Null<IInputControl>):Null<IInputControl> {
		return null;
	}

	public function updateFocus(target:Null<IInputControl>):Void {
		return;
	}

	public function interact(input:Input):Bool {
		return false;
	}
}
