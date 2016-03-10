package net.kaikoga.arpx.console;

#if flash
import flash.display.BitmapData;
#end

import net.kaikoga.arpx.camera.ICamera;
import net.kaikoga.arpx.backends.flash.console.IConsoleFlashImpl;
import net.kaikoga.arpx.backends.flash.console.ConsoleFlashImpl;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("console", "console"))
class Console implements IConsole
#if arp_backend_flash implements IConsoleFlashImpl #end
{
	@:arpType("camera") @:arpField("camera") public var cameras:Map<String, ICamera>;
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

	#end
}
