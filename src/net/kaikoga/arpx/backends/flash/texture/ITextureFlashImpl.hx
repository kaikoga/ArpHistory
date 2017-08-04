package net.kaikoga.arpx.backends.flash.texture;

import flash.geom.Rectangle;
import net.kaikoga.arp.backends.IArpObjectImpl;
import flash.display.BitmapData;

interface ITextureFlashImpl extends IArpObjectImpl {

	function bitmapData():BitmapData;
	function trim(bound:Rectangle):BitmapData;
}
