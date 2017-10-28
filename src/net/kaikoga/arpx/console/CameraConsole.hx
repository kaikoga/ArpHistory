package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arpx.camera.Camera;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.CameraConsoleFlashImpl;
#end

@:arpType("console", "console")
class CameraConsole extends Console {
	@:arpField("camera") public var cameras:IOmap<String, Camera>;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:CameraConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() super();

	override public function tick(timeslice:Float):Bool {
		for (camera in this.cameras) camera.tick(timeslice);
		return true;
	}
}
