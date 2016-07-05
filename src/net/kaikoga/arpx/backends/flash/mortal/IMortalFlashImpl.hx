package net.kaikoga.arpx.backends.flash.mortal;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IMortalFlashImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


