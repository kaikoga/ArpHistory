package net.kaikoga.arpx.screen;

import net.kaikoga.arpx.camera.Camera;
import net.kaikoga.arpx.mortal.Mortal;
import net.kaikoga.arp.ds.IList;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.screen.HudScreenFlashImpl;
#end

@:arpType("screen", "hud")
class HudScreen extends Screen {
	@:arpBarrier @:arpField("mortal") public var mortals:IList<Mortal>;
	@:arpField public var camera:Camera;

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
