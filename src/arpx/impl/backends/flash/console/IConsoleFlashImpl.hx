package arpx.impl.backends.flash.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;
import arp.impl.IArpObjectImpl;
import arpx.impl.cross.display.DisplayContext;

interface IConsoleFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
	function render(context:DisplayContext):Void;
}

#end
