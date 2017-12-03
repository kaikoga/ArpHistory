package net.kaikoga.arpx.backends.flash.screen;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface IScreenFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}
