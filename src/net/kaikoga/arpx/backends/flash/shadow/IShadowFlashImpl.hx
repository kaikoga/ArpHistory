package net.kaikoga.arpx.backends.flash.shadow;

import flash.display.BitmapData;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IShadowFlashImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


