package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.camera.Camera;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
import net.kaikoga.arpx.backends.flash.console.ConsoleFlashImpl;
#end

@:arpType("console", "console")
class Console implements IArpObject
#if (arp_backend_flash || arp_backend_openfl) implements IConsoleFlashImpl #end
{
	@:arpField("camera") public var cameras:IOmap<String, Camera>;
	@:arpField public var width:Int;
	@:arpField public var height:Int;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:ConsoleFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new() {
	}
}
