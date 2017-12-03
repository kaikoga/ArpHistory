package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.screen.Screen;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.ScreenConsoleFlashImpl;
#end

@:arpType("console", "console")
class ScreenConsole extends Console {
	@:arpField("screen") public var screens:IOmap<String, Screen>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ScreenConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (screen in this.screens) screen.tick(timeslice);
		return true;
	}
}
