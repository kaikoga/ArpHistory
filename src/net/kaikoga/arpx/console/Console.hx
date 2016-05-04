package net.kaikoga.arpx.console;

import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arpx.camera.Camera;

#if flash
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
import net.kaikoga.arpx.backends.flash.console.ConsoleFlashImpl;
import flash.display.BitmapData;
#end

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("console", "console"))
class Console implements IArpObject
#if arp_backend_flash implements IConsoleFlashImpl #end
{
	@:arpType("camera") @:arpField("camera") public var cameras:IOmap<String, Camera>;
	@:arpValue public var width:Int;
	@:arpValue public var height:Int;

	#if arp_backend_flash

	public function new() {
		flashImpl = new ConsoleFlashImpl(this);
	}

	private var flashImpl:ConsoleFlashImpl;

	inline public function display(bitmapData:BitmapData):Void {
		flashImpl.display(bitmapData);
	}

	#else

	@:arpWithoutBackend
	public function new () {
	}

	#end
}
