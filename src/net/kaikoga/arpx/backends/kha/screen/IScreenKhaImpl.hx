package net.kaikoga.arpx.backends.kha.screen;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenKhaImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}

#end
