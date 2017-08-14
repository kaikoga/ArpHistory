package net.kaikoga.arpx.backends.flash.camera;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;

interface ICameraFlashImpl extends IArpObjectImpl {
	function display(bitmapData:BitmapData):Void;
}
