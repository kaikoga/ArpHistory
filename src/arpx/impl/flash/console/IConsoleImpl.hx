package arpx.impl.flash.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arp.impl.IArpObjectImpl;

interface IConsoleImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}

#end
