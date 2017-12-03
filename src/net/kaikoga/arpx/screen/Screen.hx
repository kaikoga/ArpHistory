package net.kaikoga.arpx.screen;

import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.IScreenFlashImpl;
#end

@:arpType("screen", "null")
class Screen implements IArpObject implements ITickable
#if (arp_backend_flash || arp_backend_openfl) implements IScreenFlashImpl #end
{
	@:arpField public var ticks:Bool = false;
	@:arpField public var visible:Bool = true;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IScreenFlashImpl;
	#else
	@:arpWithoutBackend
	#end
	public function new() {
	}

	public function tick(timeslice:Float):Bool {
		return true;
	}
}
