package net.kaikoga.arpx.backends.kha.mortal;

#if arp_backend_kha

import flash.display.BitmapData;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arpx.backends.kha.math.ITransform;

interface IMortalKhaImpl extends IArpObjectImpl {

	function copySelf(bitmapData:BitmapData, transform:ITransform):Void;

	// function export():DisplayObject;

	// function frameMove():Void;

}

#end
