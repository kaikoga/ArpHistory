package net.kaikoga.arpx.backends.flash.hud;

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.flash.geom.ITransform;

interface IHudFlashImpl extends IArpObjectImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}


