package net.kaikoga.arpx.backends.flash.console;

import net.kaikoga.arp.backends.IArpObjectImpl;
import flash.display.BitmapData;

interface IConsoleFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}
