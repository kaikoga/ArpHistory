package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.HudConsoleFlashImpl;
#end

@:arpType("console", "hud")
class HudConsole extends Console {
	@:arpBarrier @:arpField("chip") public var chips:IList<Chip>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:HudConsoleFlashImpl;
	#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		return true;
	}

}
