package net.kaikoga.arpx.backends.flash.field;

import net.kaikoga.arp.backends.IArpObjectImpl;
import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IFieldFlashImpl extends IArpObjectImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


