package net.kaikoga.arpx.backends.kha.console;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IConsoleKhaImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}

#end
