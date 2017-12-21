package net.kaikoga.arpx.backends.flash.menu;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IMenuFlashImpl extends IArpObjectImpl {
	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;
}


