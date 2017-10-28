package net.kaikoga.arpx.console;

import net.kaikoga.arp.task.ITickable;
import net.kaikoga.arp.domain.IArpObject;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
#end

@:arpType("console", "null")
class Console implements IArpObject implements ITickable
#if (arp_backend_flash || arp_backend_openfl) implements IConsoleFlashImpl #end
{
	@:arpField public var width:Int;
	@:arpField public var height:Int;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:IConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
	}

	public function tick(timeslice:Float):Bool {
		return true;
	}
}
