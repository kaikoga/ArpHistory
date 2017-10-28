package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IOmap;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.CompositeConsoleFlashImpl;
#end

@:arpType("console", "console")
class CompositeConsole extends Console {
	@:arpBarrier @:arpField("console") public var consoles:IOmap<String, Console>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CompositeConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (console in this.consoles) console.tick(timeslice);
		return true;
	}

}
