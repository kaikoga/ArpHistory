package net.kaikoga.arpx.backends.flash.field;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IFieldFlashImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


