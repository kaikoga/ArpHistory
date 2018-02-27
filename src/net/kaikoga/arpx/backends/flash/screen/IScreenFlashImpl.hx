package net.kaikoga.arpx.backends.flash.screen;

#if (arp_backend_flash || arp_backend_openfl)

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}

#end
