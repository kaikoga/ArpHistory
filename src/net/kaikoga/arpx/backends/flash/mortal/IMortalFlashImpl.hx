package net.kaikoga.arpx.backends.flash.mortal;

import net.kaikoga.arp.backends.IArpObjectImpl;
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IMortalFlashImpl extends IArpObjectImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


