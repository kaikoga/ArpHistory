package net.kaikoga.arpx.backends.flash.console;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arpx.display.DisplayContext;
import net.kaikoga.arp.impl.IArpObjectImpl;

interface IConsoleFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
	function render(context:DisplayContext):Void;
}

#end
