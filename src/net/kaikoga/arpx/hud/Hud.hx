package net.kaikoga.arpx.hud;

import net.kaikoga.arpx.input.Input;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.backends.flash.hud.IHudFlashImpl;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.input.focus.IFocusContainer;
import net.kaikoga.arpx.input.IInputControl;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.mortal.IMortalFlashImpl;
#end

@:arpType("hud", "null")
class Hud implements IArpObject implements ITickable implements IFocusContainer<IInputControl> implements IInputControl
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

	public function visitFocus(other:Null<IInputControl>):Null<IInputControl> {
		return null;
	}

	public function updateFocus():Null<IInputControl> {
		var control:Null<IInputControl> = this.visitFocus(null);
		if (control != null) control.setFocus(true);
		return control;
	}

	public function setFocus(value:Bool):Void {
		return;
	}

	public function interact(input:Input):Bool {
		return false;
	}
}
