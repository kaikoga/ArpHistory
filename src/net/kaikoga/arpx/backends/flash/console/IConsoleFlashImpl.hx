package net.kaikoga.arpx.backends.flash.console;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IConsoleFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}

#end
