package net.kaikoga.arpx.hud;

import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.structs.ArpParams;
import net.kaikoga.arp.structs.ArpPosition;
import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arpx.driver.Driver;
import net.kaikoga.arpx.input.focus.IFocusNode;
import net.kaikoga.arpx.input.Input;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.hud.IHudFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.hud.IHudHeapsImpl;
#end

@:arpType("hud", "null")
class Hud implements IArpObject implements ITickable implements IFocusNode<Hud>
	#if (arp_backend_flash || arp_backend_openfl) implements IHudFlashImpl
	#elseif arp_backend_heaps implements IHudHeapsImpl
	#end
{
	@:arpBarrier @:arpField public var driver:Driver;
	@:arpField public var position:ArpPosition;
	@:arpField public var visible:Bool = true;
	@:arpField public var params:ArpParams;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IHudFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:IHudHeapsImpl;
	#end

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
