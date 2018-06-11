package arpx.impl.backends.flash.console;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import arp.impl.IArpObjectImpl;
import arpx.display.DisplayContext;

interface IConsoleFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
	function render(context:DisplayContext):Void;
}

#end
