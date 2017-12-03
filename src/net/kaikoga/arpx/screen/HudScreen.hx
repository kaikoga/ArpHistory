package net.kaikoga.arpx.screen;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arpx.chip.Chip;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.HudScreenFlashImpl;
#end

@:arpType("screen", "hud")
class HudScreen extends Screen {
	@:arpBarrier @:arpField("chip") public var chips:IList<Chip>;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:HudScreenFlashImpl;
	#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		return true;
	}

}
